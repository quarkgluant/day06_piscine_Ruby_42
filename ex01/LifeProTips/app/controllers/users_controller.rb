class UsersController < ApplicationController
  before_action :owners_only, only: %i[edit update show]

  def index
    @users = User.all
  end

  def home;
  end

  def show
    render 'users/edit'
  end

  def new
    @user = User.new
  end

  def edit;
  end

  def update
    user_params[:email].downcase!
    user_params[:name].downcase!
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render :edit
    end
    # render nothing: true
  end

  def create
    @user = User.new(user_params)
    # @user.downcase_fields
    if @user.save
      # If user saves in the db successfully:
      flash[:notice] = 'Compte créé avec succès'
      session[:user_id] = @user.id.to_s
      redirect_to root_path, notice: 'vous êtes connecté !'
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = 'Oups, création impossible...'
      redirect_to root_path
    end
  end

  def sign_in
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def owners_only
    @user = User.find(params[:id])
    unless admin?

      # redirect_to root_path if current_user != @user
    end
  end
end
