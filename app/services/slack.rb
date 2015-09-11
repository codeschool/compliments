require "net/http"
require "uri"

module Slack
  include Rails.application.routes.url_helpers

  SLACK_INCOMING_WEBHOOK = ENV["SLACK_INCOMING_WEBHOOK"]

  def self.notify_compliment(compliment)
    uri = URI.parse(SLACK_INCOMING_WEBHOOK)
    response =  Net::HTTP.post_form(uri, { payload: compliment_json(compliment) })
  end

  def self.notify_quote(quote)
    uri = URI.parse(SLACK_INCOMING_WEBHOOK)
    response =  Net::HTTP.post_form(uri, { payload: quote_json(quote) })
  end

  def self.compliment_json(compliment)
    {
      icon_emoji: ":compliments:",
      username: "Compliment Bot",
      text: "New compliment from #{compliment.complimenter_name}!",
      attachments: [
        {
          fallback: "#{compliment.complimenter_name} said something nice to #{compliment.complimentee_name}.",
          color: "#f45950",
          fields: [
            {
              title: "#{compliment.complimenter_name} said something nice to #{compliment.complimentee_name}:",
              value: compliment.text,
              short: false
            }
          ]
        }
      ]
    }.to_json
  end

  def self.quote_json(quote)
    {
      icon_emoji: ":quotes:",
      username: "Quote Bot",
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
