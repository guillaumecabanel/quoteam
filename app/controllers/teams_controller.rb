class TeamsController < ApplicationController
  before_action :set_team, only: [:show]

  def index
    @teams = policy_scope(Team)
    authorize @teams
  end

  def show
    @quotes = Quote.where(team: @team)
    @quote = Quote.new
    authorize @quote
    @members = Enrollment.where(team: @team)
  end

  def new
    @team = Team.new
    authorize @team
  end

  def create
    @team = Team.new(team_params)
    authorize @team
    if @team.save
      Enrollment.create(user: current_user, team: @team)
      flash[:notice] = t('.team_created', team: @team.name)
      redirect_to team_path(@team)
    else
      render 'new'
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
      authorize @team
    end

    def team_params
      params.require(:team).permit(:name)
    end
end
