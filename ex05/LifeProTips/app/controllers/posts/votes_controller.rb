class Posts::VotesController < ApplicationController
  before_action :set_post
  before_action :authenticate_user

  def create
    vote = @post.votes.where(user_id: current_user.id).first_or_create
    # value = vote.value + params[:value].to_i
    vote.update_attributes(value: params[:value])
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Post has a vote' }
      format.json { render :show, status: :ok, location: @post }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
