# frozen_string_literal: true

# this is the base controller for all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_notifications, if: :current_user
  before_action :set_categories
  before_action :set_query
  before_action :set_stripe_key

  def viewer_counter(test, test1 = nil)
    if current_user == test || current_user == test1
      test.update(views: test.views)
    else
      test.update(views: test.views + 1)
    end
  end

  def set_query
    @query = Post.ransack(params[:q])
  end

  def admin
    redirect_to root_path, alert: 'You are not authorized to do that.' unless current_user&.admin?
  end

  private

  def set_stripe_key
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
  end

  def set_categories
    @nav_categories = Category.where(display_in_nav: true).order(:name)
  end

  def set_notifications
    notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end
end
