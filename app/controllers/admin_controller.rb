class AdminController < ApplicationController
  def index; end

  def posts
    @posts = Post.all.includes(:user)
    @t = Post.includes(:user).ransack(params[:q])
    @posts = @t.result.page(params[:page]).per_page(15)
  end

  def comments
    @comments = Comment.all.includes(:user, :post, :rich_text_body)
    @t = Comment.includes(:user, :post, :rich_text_body).ransack(params[:q])
    @comments = @t.result.page(params[:page]).per_page(15)
  end

  def categories
    @categories = Category.all
  end

  def users
    @use = User.all
    @t = User.ransack(params[:q])
    @use = @t.result.page(params[:page]).per_page(15)
  end

  def show_post
    @post = Post.includes(:user, comments: %i[user rich_text_body]).find(params[:id])
  end

  def show_user
    @post = Post.all
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url, notice: 'User deleted.' if @user.destroy
  end
end
