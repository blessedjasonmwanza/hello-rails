class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.where(author_id: params[:user_id]).order(created_at: :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
    @params = params
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'New post created successfully'
      redirect_to user_post_path(id: @post.id, user_id: @post.author_id)
    else
      render :new, status: :unprocessable_entity, content_type: 'text/html'
      headers['Content-Type'] = 'text/html'
      flash[:danger] = 'Post could not be created'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end
end
