class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def edit
    session[:return_to] ||= request.referer
  end

  def update
    if @user.update(user_params)
      flash[:notice] = t('.profile_updated')
      if session[:return_to] == new_user_registration_url
        redirect_to root_path
      else
        redirect_to session.delete(:return_to)
      end

    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:nickname)
    end

    def set_user
      @user = current_user
      authorize @user
    end
end
