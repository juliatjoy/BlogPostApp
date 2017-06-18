class CommentsController < ApplicationController
  before_action :set_blog_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @blog_post.comments.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    binding.pry
    @comment = @blog_post.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @blog_post.comments.new(comment_params.merge(user_id: current_user.id))
    binding.pry
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to blog_post_path(@blog_post, @comment), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = @blog_post.comments.find(params[:id])
    end

    def set_blog_post
      @blog_post = BlogPost.find(params[:blog_post_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      binding.pry
      params.require(:comment).permit(:user_id, :blog_post_id, :body)
    end
end