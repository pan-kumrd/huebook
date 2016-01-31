class CommentsController < AppController
    load_and_authorize_resource
    before_action :set_post_id, only: [:index, :show, :like, :unlike, :likes, :create, :destroy]
    before_action :set_comment, only: [:show, :like, :unlike, :likes, :destroy]
    layout false

    # GET /posts/:post_id/comments.json
    def index
        comments = Comment.where({ post_id: @post_id }).order(created_at: :asc)
        render json: comments
    end

    # GET /posts/:post_id/comments/:id.json
    def show
        render json: @comment
    end

    # POST /posts/:post_id/comments/:id/like.json
    def like
        Like.create(object: @comment,
                    user: current_user)
        @comment.likes_count += 1
        @comment.save
        render json: @comment
    end

    # POST /posts/:post_id/comments/:id/unlike.json
    def unlike
        Like.where(object: @comment,
                   user: current_user).destroy_all
        @comment.likes_count -= 1
        @comment.save
        render json: @comment
    end

    # GET /posts/:post_id/comments/:id/likes.json
    def likes
        user_ids = Like.where({ object: @comment }).pluck(:user_id)
        users = User.find(user_ids)
        render json: { comment: @comment, users: users }, serializer: CommentLikesSerializer, root: false
    end

    # POST /posts/:post_id/comments.json
    def create
        comment = Comment.new(post_params)
        comment.post_id = @post_id
        comment.user = current_user
        comment.save
        post = Post.find(@post_id)
        post.comments_count += 1
        post.save
        render json: { post: post, comment: comment }, serializer: NewCommentSerializer, root: false
    end

    # DELETE /posts/:post_id/comments/:id.json
    def destroy
        @comment.destroy
        post = Post.find(@post_id)
        post.comments_count -= 1
        post.save
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    private

    # use callbacks to share common setup or constraints between actions.
    def set_post_id
        @post_id = params[:post_id]
    end

    def set_comment
        # Silly routing is silly, some actions have :id, some :comment_id
        id = (params.has_key?(:id) ? params[:id] : params[:comment_id])
        @comment = Comment.find(id)
    end

    # never trust parameters from the scary internet, only allow the white list through.
    def post_params
        params.require(:comment).permit(:text)
    end
end
