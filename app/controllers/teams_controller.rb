class TeamsController < ApplicationController
  def show
    set_team
    authorize @team
    @quotes = policy_scope(Quote)
    @quote = Quote.new
    authorize @quote
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end
end
