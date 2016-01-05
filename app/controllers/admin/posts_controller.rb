class Admin::PostsController < Admin::ApplicationController
  def index
    if params[:search].present?
      @posts = Post.where("title LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").page params[:page]
    else
      @posts = Post.all.order(id: :desc).page params[:page]
    end
  end

  def new
    @post = Post.new
  end

  def create
    # post = post_params
    # post[:tag_ids].reject! { |p| p.blank? }

    @post = Post.new(post_params)
    @post.moderator_id = current_moderator.id

    if @post.save
      redirect_to admin_posts_url, notice: 'Post was successfully created'
    else
      flash.now[:alert] = 'There was a problem creating post'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_url, notice: 'Post was successfully updated'
    else
      flash[:alert] = 'There was a problem updating post'
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to admin_posts_url, notice: 'Post was successfully deleted'
  end
  
  private
  
  def post_params
    params.require(:post).permit(:id, :title, :avatar, :content, :bootsy_image_gallery_id, :publish, tag_ids: [])
  end
end
