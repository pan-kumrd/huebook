class UserSerializer < ActiveModel::Serializer
    attributes :id,
               :first_name,
               :last_name,
               :email,
               :bio,
               :profile_picture_file_name,
               :created_at,
               :is_me

    has_one :friendship

    def initialize(obj, params = {})
        super(obj)

        # FIXME: This is a hack that workaround a bug in ActiveModel, which breaks
        # passing of a options down to each_iterator, see UserSearchSerializer.
        if params.key? :current_user then
            @current_user = params[:current_user]
        elsif @serialization_options and @serialization_options.key? :current_user then
            @current_user = @serialization_options[:current_user]
        end
        @root = (params.key? :root ? params[:root] : true)
    end

    def email
        if @current_user.id == object.id then
            return object.email
        else
            return nil
        end
    end

    def friendship
        if @current_user then
            f = Friendship.where("(initiator_id = ? AND friend_id = ?) OR (initiator_id = ? AND friend_id = ?)",
                                 @current_user.id, object.id, object.id, @current_user.id)
            (f ? f[0] : nil)
        else
            nil
        end
    end

    def is_me
        if @current_user.id == object.id then
            return true
        else
            return false
        end
    end
end

