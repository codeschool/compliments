require "net/http"
require "uri"

module Slack
  include Rails.application.routes.url_helpers

  SLACK_INCOMING_WEBHOOK = ENV["SLACK_INCOMING_WEBHOOK"]

  SLACK_COMPLIMENTS_CHANNEL_ID = ENV["SLACK_COMPLIMENTS_CHANNEL_ID"]
  SLACK_COMPLIMENTS_CHANNEL_NAME = ENV["SLACK_COMPLIMENTS_CHANNEL_NAME"]

  SLACK_QUOTES_CHANNEL_ID = ENV["SLACK_QUOTES_CHANNEL_ID"]
  SLACK_QUOTES_CHANNEL_NAME = ENV["SLACK_QUOTES_CHANNEL_NAME"]

  def self.webhook_uri
    URI.parse(SLACK_INCOMING_WEBHOOK)
  end

  def self.compliments_channel_link
    "<##{SLACK_COMPLIMENTS_CHANNEL_ID}|#{SLACK_COMPLIMENTS_CHANNEL_NAME}>"
  end

  def self.quotes_channel_link
    "<##{SLACK_QUOTES_CHANNEL_ID}|#{SLACK_QUOTES_CHANNEL_NAME}>"
  end

  def self.notify_compliment(compliment)
    Net::HTTP.post_form(webhook_uri, {
      payload: compliment_json(compliment)
    })

    Net::HTTP.post_form(webhook_uri, {
      payload: compliment_notice_json(compliment)
    })
  end

  def self.notify_quote(quote)
    Net::HTTP.post_form(webhook_uri, {
      payload: quote_json(quote)
    })

    Net::HTTP.post_form(webhook_uri, {
      payload: quote_notice_json(quote)
    })
  end

  def self.compliment_json(compliment)
    {
      channel: "##{SLACK_COMPLIMENTS_CHANNEL_NAME}",
      icon_emoji: ":compliments:",
      username: "Compliment Bot",
      text: "*From #{compliment.complimenter_name} to #{compliment.complimentee_name}:*",
      attachments: [
        {
          fallback: "#{compliment.complimenter_name} said something nice to #{compliment.complimentee_name}.",
          color: "#f45950",
          mrkdwn_in: ["fields"],
          fields: [
            {
              value: compliment.text,
              short: false
            }
          ]
        }
      ]
    }.to_json
  end

  def self.compliment_notice_json(compliment)
    {
      channel: "@#{compliment.complimentee_slack_username}",
      icon_emoji: ":compliments:",
      username: "Compliment Bot",
      attachments: [
        {
          fallback: "#{compliment.complimenter_name} said something nice about you.",
          color: "#f45950",
          mrkdwn_in: ["fields"],
          fields: [
            {
              value: "#{compliment.complimenter_name} said something nice about you in #{compliments_channel_link}.",
              short: false
            }
          ]
        }
      ]
    }.to_json
  end

  def self.quote_json(quote)
    {
      channel: "##{SLACK_QUOTES_CHANNEL_NAME}",
      icon_emoji: ":quotes:",
      username: "Quote Bot",
      text: "*#{quote.quoter_name} heard #{quote.quotee_name} say:*",
      attachments: [
        {
          fallback: "#{quote.quotee_name} said something worth hearing.",
          color: "#616eb3",
          mrkdwn_in: ["fields"],
          fields: [
            {
              value: quote.text,
              short: false
            }
          ]
        }
      ]
    }.to_json
  end

  def self.quote_notice_json(quote)
    {
      channel: "@#{quote.quotee_slack_username}",
      icon_emoji: ":quotes:",
      username: "Quote Bot",
      attachments: [
        {
          fallback: "#{quote.quoter_name} quoted you.",
          color: "#616eb3",
          mrkdwn_in: ["fields"],
          fields: [
            {
              value: "#{quote.quoter_name} quoted you in #{quotes_channel_link}. You're hilarious.",
              short: false
            }
          ]
        }
      ]
    }.to_json
  end
end
