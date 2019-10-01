class Admin::PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :admin?

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order(created_at: :desc, title: :asc, user_id: :asc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @edit_by_name = User.find(@post.edit_by_user_id).name
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    # @post = Post.new(post_params)
    # @post.user_id = current_user.id
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render 'admin/posts/new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params) && @post.update_attribute(:edit_by_user_id, current_user.id)
        format.html { redirect_to admin_posts_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render 'admin/posts/edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:user_id, :title, :content)
  end


end
