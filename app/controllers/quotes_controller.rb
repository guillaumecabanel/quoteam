class QuotesController < ApplicationController
  before_action :set_quote, only: [:update, :destroy, :upvote]
  before_action :set_team, only: [:index, :create, :update, :upvote, :destroy]

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

  def upvote
    @quote.liked_by current_user
    @quote.dislike_by current_user unless @quote.vote_registered?

    authorize @quote
    redirect_to team_quotes_path(@team)
  end

  private

    def set_team
      @team = Team.find(params[:team_id])
      authorize @team
    end

    def set_quote
      @quote = Quote.find(params[:id])
    end

    def quote_params
      params.require(:quote).permit(:content, :author)
    end
end
