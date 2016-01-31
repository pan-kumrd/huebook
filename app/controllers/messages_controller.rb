class MessagesController < AppController
    layout false

    def conversations
        raw_query = "SELECT (CASE WHEN sender_id = ? THEN to_id ELSE sender_id END) AS user_id,
                                SUM(CASE WHEN delivered = 't' AND to_id = ? THEN 1 ELSE 0 END) AS delivered_cnt,
                                SUM(CASE WHEN to_id = ? THEN 1 ELSE 0 END) AS received_cnt
                         FROM messages
                         WHERE sender_id = ? OR to_id = ?
                         GROUP BY user_id"
        query = Message.send(:sanitize_sql_array,
                             [ raw_query, current_user.id, deliveredValue, current_user.id, current_user.id, current_user.id, current_user.id ])
        results = Message.find_by_sql(query)
        render json: results, each_serializer: ConversationSerializer, root: "conversations"
    end

    def index
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
        # TODO: Limit to N latest messages
        render json: msgs
    end

    def sendMsg
        message = Message.new(post_params)
        message.sender = current_user
        message.save
        render json: message
    end

    def ack
        Message.where('sender_id = ? AND to_id = ?', params[:id], current_user.id).update_all(delivered: true)
        render json: {}
    end

    protected
    def post_params
        params.require(:message).permit(:text, :to_id)
    end
end

