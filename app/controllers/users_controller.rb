class UsersController < ApplicationController
  before_action :authenticate_user!
  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @recent_posts = Post.includes(:author, :comments,
                                  :likes).where(author_id: params[:id]).order(created_at: :desc).limit(3)
  end
end
