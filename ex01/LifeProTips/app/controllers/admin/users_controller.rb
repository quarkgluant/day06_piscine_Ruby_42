class Admin::UsersController < ApplicationController
  before_action :admin?
  before_action :identify_user, only: %i[edit show update destroy]

  def index
    if admin?
      @users = User.all
      render
    else
      flash[:alert] = 'Accès non autorisé'
      redirect_to root_path
    end
  end

  def show; end

  def edit; end

  def update
    user_params[:email].downcase!
    user_params[:name].downcase!
    @user.name.downcase!
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render :edit
    end
    # render nothing: true
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def identify_user
    @user = User.find(params[:id])
  end
end

