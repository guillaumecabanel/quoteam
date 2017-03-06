class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    redirect_to teams_path if current_user
  end

  def admin
    if current_user && current_user.admin?
      @teams = Team.order(:name)
      @users = User.order(:created_at)
    else
      redirect_to root_path
    end
  end
end
