class SearchController < AppController
    layout false

    # GET /search/users/:query
    def users
        authorize! :search, Search

        q = sprintf('%%%s%%', params[:query])
        users = User.where("LOWER(first_name) LIKE LOWER(?) OR LOWER(last_name) LIKE LOWER(?)", q, q)
        # FIXME: Special serializer to workaround an ActiveModel bug, see
        # UserSearchSerializer for details.
        render json: users, serializer: UserSearchSerializer,
                            current_user: current_user,
                            root: false
    end

    # GET /search/posts/:query
    def posts
        authorize! :search, Search

        q = sprintf('%%%s%%', params[:query])
        posts = Post.where("LOWER(text) LIKE LOWER(?)", q)
        print posts
        render json: posts, serializer: ActiveModel::ArraySerializer,
                            each_serializer: PostSerializer,
                            root: 'posts'
    end

    # GET /search/events/:query
    def events
        authorize! :search, Search

        q = sprintf('%%%s%%', params[:query])
        events = Event.where("LOWER(name) LIKE LOWER(?)", q)
        render json: events, serializer: ActiveModel::ArraySerializer,
                             each_serializer: EventSerializer,
                             root: 'events'
    end

end
