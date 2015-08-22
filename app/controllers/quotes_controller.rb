class QuotesController < ApplicationController
  before_action :find_quote, only: [:show, :edit, :update, :destroy]

  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      redirect_to quotes_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @quote.update_attributes(quote_params)
      redirect_to quotes_path
    else
      render :edit
    end
  end

  def destroy
    if @quote.destroy
      redirect_to quotes_path
    else
      render :show
    end
  end

  private

  def find_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:user_id, :text)
  end
end
