class QuotesController < ApplicationController
  def index
    Quote.all.order('created_at DESC')
  end
end
