class SearchController < AppController
    layout false

    # GET /search/users/:query
    def users
        q = sprintf('%%%s%%', params[:query])
        users = User.where("first_name LIKE ? OR last_name LIKE ?", q, q)
        # FIXME: Special serializer to workaround an ActiveModel bug, see
        # UserSearchSerializer for details.
        render json: users, serializer: UserSearchSerializer, current_user: current_user, root: false
    end

    # GET /search/posts/:query
    def posts
        q = sprintf('%%%s%%', params[:query])
        posts = Post.where("text LIKE ?", q)
        print posts
        render json: posts, serializer: ActiveModel::ArraySerializer,
                            each_serializer: PostSerializer,
                            root: 'posts'
    end

    # GET /search/events/:query
    def events
        q = sprintf('%%%s%%', params[:query])
        events = Event.where("name LIKE ?", q)
        render json: events, serializer: ActiveModel::ArraySerializer,
                             each_serializer: EventSerializer,
                             root: 'events'
    end

end
