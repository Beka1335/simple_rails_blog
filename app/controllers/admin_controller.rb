# frozen_string_literal: true

# this is AdminController
class AdminController < ApplicationController
  def index; end

  def posts
    @posts = Post.all.includes(:user)
  end

  def comments
    @comments = Comment.all.includes(:user, :post, :rich_text_body)
  end

  def categories
    @categories = Category.all
  end

  def users
    @use = User.all
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
    if @user.destroy
      redirect_to root_url, notice: 'User deleted.'
    end
  end
end
