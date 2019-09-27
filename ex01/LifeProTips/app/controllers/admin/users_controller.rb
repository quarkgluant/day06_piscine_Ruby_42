class Admin::UsersController < ApplicationController
  before_action :admin?

  def index
    if admin?
      @users = User.all
      render :index
    else
      flash[:alert] = 'Accès non autorisé'
      redirect_to root_path
    end
  end

  def show
    @user = User.find(id)
  end

  def edit

  end

  def update

  end

  def destroy

  end
end

