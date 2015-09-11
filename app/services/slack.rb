require "net/http"
require "uri"

module Slack
  include Rails.application.routes.url_helpers

  SLACK_INCOMING_WEBHOOK = ENV["SLACK_INCOMING_WEBHOOK"]

  def self.notify_quote(quote)
    uri = URI.parse(SLACK_INCOMING_WEBHOOK)
    response =  Net::HTTP.post_form(uri, { payload: quote_json(quote)) })
  end

  def self.quote_json(quote)
    {
      text: "New quote overheard by #{quote.quoter_name}!",
      attachments: [
        {
          fallback: "#{quote.quotee_name} said something worth hearing.",
          color: "#616eb3",
          fields: [
            {
              title: "#{quote.quotee_name} said:",
              value: quote.text,
              short: false
            }
          ]
        }
      ]
    }.to_json
  end
end
