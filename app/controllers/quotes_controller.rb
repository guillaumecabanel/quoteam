class QuotesController < ApplicationController
  before_action :set_quote, only: [:destroy, :upvote]
  before_action :find_team, only: [:create, :upvote, :destroy]

  def create
    @quote = Quote.new(quote_params)
    @quote.team = @team
    authorize @quote
    if @quote.save
      redirect_to team_path(@team)
    else
      redirect_to team_path(@team)
    end
  end

  def destroy
    @quote.destroy
    authorize @quote
    redirect_to team_path(@team)
  end

  def upvote
    @quote.liked_by current_user
    @quote.dislike_by current_user unless @quote.vote_registered?

    authorize @quote
    redirect_to team_path(@team)
  end

  private

    def find_team
      @team = Team.find(params[:team_id])
    end

    def set_quote
      @quote = Quote.find(params[:id])
    end

    def quote_params
      params.require(:quote).permit(:content, :author)
    end
end
