class EnrollmentsController < ApplicationController
  def new
    @enrollment = Enrollment.new
    authorize @enrollment
    @team = Team.new
  end

  def create
    @team = Team.find_by_secret_id(team_params[:secret_id])
    authorize @team
    if @team
      Enrollment.create(user: current_user, team: @team)
      redirect_to team_path(@team)
    else
      render 'new'
    end
  end

  private

    def team_params
      params.require(:team).permit(:secret_id)
    end

end
