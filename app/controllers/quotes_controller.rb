class QuotesController < ApplicationController
  before_action :set_quote, only: [:update, :destroy, :like]
  before_action :set_team, only: [:index, :create, :update, :like, :destroy]

  def index
    @quotes = policy_scope(Quote.where(team: @team))
    authorize @quotes
    @quote = Quote.new
    authorize @quote
    @members = Enrollment.where(team: @team)
  end

  def create
    @quote = Quote.new(quote_params)
    @quote.team = @team
    @quote.user = current_user
    authorize @quote
    if @quote.save
      redirect_to team_quotes_path(@team)
    else
      redirect_to team_quotes_path(@team)
    end
  end

  def update
    @quote.update(quote_params)
    authorize @quote
    redirect_to team_quotes_path(@team)
  end

  def destroy
    @quote.destroy
    authorize @quote
    flash[:notice] = t('.quote_deleted')
    redirect_to team_quotes_path(@team)
  end

  def like
    if current_user.voted_for? @quote
      current_user.unvote_for @quote
    else
      current_user.up_votes @quote
    end

    authorize @quote
  end

  private

    def set_team
      @team = Team.find(params[:team_id])
    end

    def set_quote
      @quote = Quote.find(params[:id])
    end

    def quote_params
      params.require(:quote).permit(:content, :author)
    end
end
