class QuotesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:random, :slack]
  skip_before_filter :verify_authenticity_token, only: [:slack]

  http_basic_authenticate_with name: "internals", password: ENV["RANDOM_QUOTES_PASSWORD"], only: :random

  before_filter :validate_slack_token, only: :slack

  before_action :find_quote, only: [:show, :edit, :update, :destroy]

  def index
    @quotes = Quote.all
  end

  def given
    @quotes = current_user.quotes_given
    render :index
  end

  def attributed
    @quotes = current_user.quotes_attributed
    render :index
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

  def slack
    quote_command = SlashCommand::Quote.new(user_id: params[:user_id], text: params[:text])

    @quote = Quote.new(
      quoter: quote_command.quoter,
      quotee: quote_command.quotee,
      text: quote_command.quote
    )

    if @quote.save
      render text: "Posted your quote!"
    else
      render text: "Oops! Something went wrong :("
    end
  end

  def show
  end

  def random
    @quote = Quote.random

    render :show
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
    params.require(:quote).permit(:quoter_id, :quotee_id, :text)
  end

  def validate_slack_token
    # render text: 'Nope!', status: 401 if params[:token] != ENV['SLACK_QUOTES_TOKEN']
  end
end
