class EnrollmentsController < ApplicationController
  def new
    @enrollment = Enrollment.new
    authorize @enrollment
    @team = Team.new
  end

  def create
    @team = Team.find_by_invite_code(team_params[:invite_code])
    if @team
      authorize @team
      Enrollment.create(user: current_user, team: @team)
      flash[:notice] = t('.team_added', team: @team.name)
      redirect_to team_path(@team)
    else
      @team = Team.new
      authorize @team
      flash[:alert] = t('.invalid_code')
      render 'new'
    end
  end

  private

    def team_params
      params.require(:team).permit(:invite_code)
    end

end
