class Admin::VotesController < ApplicationController
  before_action :set_post, only: :create
  before_action :authenticate_user

  def create
    vote = @post.votes.where(user_id: current_user.id).first_or_create
    # value = vote.value + params[:value].to_i
    vote.update_attributes(value: params[:value])
    respond_to do |format|
      format.html { redirect_to @post, notice: "Post has a #{value} vote" }
      format.json { render :show, status: :ok, location: @post }
    end
  end

  def index
    @posts = Post.order(created_at: :desc, title: :asc, user_id: :asc)
  end

  def destroy
    vote = @post.votes.where(user_id: current_user.id)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end

