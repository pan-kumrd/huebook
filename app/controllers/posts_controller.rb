class PostsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    before_action :set_post, only: [:show, :edit, :like, :unlike, :update, :destroy]
    layout false

    # GET /posts
    # GET /posts.json
    # TODO: Move to wall
    def index
        @posts = Post.all
        render json: @posts
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
        @post.save()
        render json: @post
    end

    # POST /posts/1/unlike
    # POST /posts/1/unlike.json
    def unlike
        Like.where(object: @post,
                   user: current_user).destroy_all
        @post.likes_count -= 1
        @post.save()
        render json: @post
    end

    # GET /posts/new
    def new
        @post = Post.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts
    # POST /posts.json
    def create
        @post = Post.new(post_params)

        respond_to do |format|
            if @post.save
                format.json { render :show, status: :created, location: @post }
            else
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
        respond_to do |format|
            if @post.update(post_params)
                format.json { render :show, status: :ok, location: @post }
            else
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
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
        params[:post]
    end
end
