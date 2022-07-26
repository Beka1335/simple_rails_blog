# frozen_string_literal: true

# This is the UsersController class
class UsersController < ApplicationController
  before_action :set_user
  def profile
    viewer_counter(@user)
    @posts = @user.posts.includes(:rich_text_body).where(approve: true).order(views: :desc).paginate(page: params[:page], per_page: 5)
    @total_views = 0

    @posts.each do |post|
      @total_views += post.views
    end
  end

  def uneproved_posts
    viewer_counter(@user)
    @posts = @user.posts.includes(:rich_text_body).where(approve: false).order(views: :desc).paginate(page: params[:page], per_page: 5)
  end

  def user_role_admin
    @user.update(role: 1)
    redirect_to admin_users_path
  end

  def user_role_user
    @user.update(role: 0)
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
