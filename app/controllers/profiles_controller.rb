class ProfilesController < ApplicationController

  private

    def user_params
      # params.require(:user).permit(:team_id)
    end

    def set_user
      @user = current_user
    end
end
