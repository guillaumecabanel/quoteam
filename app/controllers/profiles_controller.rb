class ProfilesController < ApplicationController
  
  def enroll
    set_user
    authorize @user
    if @user.update(user_params)
      redirect_to team_quotes_path(@user.team)
    else
      render root_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:team_id)
    end

    def set_user
      @user = current_user
    end
end
