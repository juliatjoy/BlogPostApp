class BlogPostsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :like_or_unlike]

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def index
    @blog_posts = BlogPost.all
  end

  def my_blogs
    @my_blogs = current_user.blog_posts
  end

  def create
    @blog_post = BlogPost.new(blog_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @blog_post.update(blog_params)
        format.html { redirect_to @blog_post, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def home
  end

  def destroy
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like_or_unlike
    if current_user.voted_for? @blog_post
      @blog_post.unliked_by current_user
    else
      @blog_post.liked_by current_user
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog_post = BlogPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog_post).permit(:user_id, :title, :body)
    end

end
