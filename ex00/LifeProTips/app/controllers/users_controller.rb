class UsersController < ApplicationController

  def index
    cookies[:animal] = {
        value: get_random_animal,
        expires: Time.current + 1.minute
    }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # If user saves in the db successfully:
      flash[:notice] = 'Compte créé avec succès'
      session[:user_id] = @user.id.to_s
      redirect_to root_path, notice: 'vous êtes connecté !'
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = 'Oups, création impossible...'
      render 'users/sign_in'
    end
  end

  def sign_in
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
