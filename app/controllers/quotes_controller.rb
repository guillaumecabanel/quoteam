class QuotesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  before_action :set_quote, only: [:destroy, :upvote]

  def index
    @quotes = policy_scope(Quote)
    @quote = Quote.new
    authorize @quote
  end

  def create
    @quote = Quote.new(quote_params)
    authorize @quote
    if @quote.save
      redirect_to quotes_path
    else
      redirect_to quotes_path
    end
  end

  def destroy
    @quote.destroy
    authorize @quote
    redirect_to quotes_path
  end

  def upvote
    @quote.liked_by current_user
    @quote.dislike_by current_user unless @quote.vote_registered?

    authorize @quote
    redirect_to quotes_path
  end

  private

    def set_quote
      @quote = Quote.find(params[:id])
    end

    def quote_params
      params.require(:quote).permit(:content, :author)
    end
end
