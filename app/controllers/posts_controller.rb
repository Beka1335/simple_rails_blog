class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy approve_post unapprove_post]
  before_action :authenticate_user!, except: %i[show index]

  def unapprove_post
    @post.update(approve: false)
    redirect_to admin_posts_path
  end

  def approve_post
    @post.update(approve: true)
    # mail = UsersMailer.approve_post(@post.user_id)
    # mail.deliver_now
    redirect_to admin_posts_path
  end

  def index
    @posts = if current_user.nil?
               Post.includes(:user, :rich_text_body).where(approve: true, premium: false)
                   .order(views: :desc).paginate(page: params[:page], per_page: 5)
             elsif current_user.subscribed?
               Post.includes(:user, :rich_text_body).where(approve: true)
                   .order(views: :desc).paginate(page: params[:page], per_page: 5)
             else
               Post.includes(:user, :rich_text_body).where(approve: true, premium: false)
                   .order(views: :desc).paginate(page: params[:page], per_page: 5)
             end
  end

  def show
    viewer_counter(@post, @post.user)
    @comments = @post.comments.includes(:user, :rich_text_body).order(created_at: :desc)

    mark_notifications_as_read
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      save(format)
    end
  end

  def save(format)
    if @post.save
      format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
      format.json { render :show, status: :created, location: @post }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
    redirect_to @post, status: :moved_permanently if params[:id] != @post.slug
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :premium)
  end

  def mark_notifications_as_read
    return unless current_user

    notifications_to_mark_as_read = @post.notifications_as_post.where(recipient: current_user)
    notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
  end

  def require_login
    redirect_to new_user_registration_path unless current_user
  end
end
