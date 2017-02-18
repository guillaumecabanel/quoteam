class EnrollmentsController < ApplicationController
  def new
    @enrollment = Enrollment.new
    authorize @enrollment
    @team = Team.new
  end

  def create
    @team = Team.find_by_invite_code(team_params[:invite_code])
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
      params.require(:team).permit(:invite_code)
    end

end
