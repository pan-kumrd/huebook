class PostsController < AppController
    load_and_authorize_resource
    before_action :set_post, only: [:show, :like, :unlike, :likes, :shares, :destroy]
    layout false

    # GET /posts
    # GET /posts.json
    def index
        posts = Post.all.ordered(created_at: :desc)
        render json: posts
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
        render json: @post
    end

    # POST /posts/1/like
    # POST /posts/1/like.json
    def like
        Like.create(object: @post,
                    user: current_user)
        @post.likes_count += 1
        @post.save
        render json: @post
    end

    # POST /posts/1/unlike
    # POST /posts/1/unlike.json
    def unlike
        Like.where(object: @post,
                   user: current_user).destroy_all
        @post.likes_count -= 1
        @post.save
        render json: @post
    end

    # GET /posts/1/likes.json
    def likes
        user_ids = Like.where({ object: @post }).pluck(:user_id)
        users = User.find(user_ids)
        render json: { post: @post, users: users }, serializer: PostLikesSerializer, root: false
    end

    def shares
        shares = @post.shares
        render json: shares
    end

    # POST /posts/create
    def create
        post = Post.new(post_params)
        post.user = current_user
        post.save
        render json: post
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
        @post.destroy
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    private

    # use callbacks to share common setup or constraints between actions.
    def set_post
        @post = Post.find(params[:id])
    end

    # never trust parameters from the scary internet, only allow the white list through.
    def post_params
        params.require(:post).permit(:text, :private, :wall_id, :wall_type)
    end
end
