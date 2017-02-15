class QuotesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

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
      render "index"
    end
  end

  private
    def quote_params
      params.require(:quote).permit(:content, :author)
    end
end
