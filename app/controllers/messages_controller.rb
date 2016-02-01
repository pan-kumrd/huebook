class MessagesController < AppController
    layout false
    authorize_resource

    # GET /messages/conversations
    def index
        authorize! :index, Message

        raw_query = "SELECT (CASE WHEN sender_id = ? THEN to_id ELSE sender_id END) AS user_id,
                                SUM(CASE WHEN delivered = 't' AND to_id = ? THEN 1 ELSE 0 END) AS delivered_cnt,
                                SUM(CASE WHEN to_id = ? THEN 1 ELSE 0 END) AS received_cnt
                         FROM messages
                         WHERE sender_id = ? OR to_id = ?
                         GROUP BY user_id"
        query = Message.send(:sanitize_sql_array,
                             [ raw_query, current_user.id, current_user.id, current_user.id, current_user.id, current_user.id ])
        results = Message.find_by_sql(query)
        render json: results, each_serializer: ConversationSerializer, root: "conversations"
    end

    # GET /messages/:id
    def show
        msgs = Message.where("(sender_id = ? AND to_id = ?) OR (sender_id = ? AND to_id = ?)",
                             current_user.id, params[:id], params[:id], current_user.id)
        if params.has_key? :since then
            if ActiveRecord::Base.connection.adapter_name == 'SQLite' then
                msgs = msgs.where("created_at >= datetime(?, 'unixepoch')", params[:since].to_i())
            else
                msgs = msgs.where("created_at >= ?", params[:since].to_i())
            end
        end

        msgs = msgs.order(created_at: :asc)
        msgs = msgs.accessible_by(current_ability)
        # TODO: Limit to N latest messages
        render json: msgs
    end

    # POST /messages/sendMsg
    def create
        authorize! :create
        message = Message.new(message_params)
        message.sender = current_user
        message.save
        render json: message
    end

    # POST /messages/:id/ack
    def ack
        authorize! :ack, Message
        Message.where('sender_id = ? AND to_id = ?', params[:id], current_user.id).update_all(delivered: true)
        render json: {}
    end

    protected
    def message_params
        params.require(:message).permit(:text, :to_id)
    end
end

