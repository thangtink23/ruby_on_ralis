class ProfilesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:avatar]
  before_action :authenticate_user!, only: [:change_password, :update_password]

  def show
    @user = User.find_by(id: params[:id])
    @reviews = @user.reviews.paginate(page: params[:page])
  end

  def avatar
    @user = User.find_by(id: params[:id])
    @user.update_attributes(avatar: params[:profile][:avatar])
    respond_to do |format|
      format.html {redirect_to user_profile_path(@user.id)}
      format.js
    end
  end

  def change_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.valid_password?(params[:user][:current_password])
      if @user.update_attributes(params_password)
        bypass_sign_in(@user)
        redirect_to root_path
      else
        flash.now[:error] = "Password and Password comfirmation invalid"
        render 'change_password'
      end
    else
      flash.now[:error] = "Current_password invaild"
      render 'change_password'
    end
  end

  private
  def params_avatar
    params.require(:profile).permit(:avatar)
  end

  def params_password
    params.require(:user).permit(:password, :password_confirmation)
  end
end
