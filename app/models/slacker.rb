require "net/http"
require "uri"

class Slacker
  SLACK_TOKEN = ENV['SLACK_TOKEN']

  attr_reader :id, :username, :email

  def self.all
    uri = URI.parse("https://slack.com/api/users.list?token=#{SLACK_TOKEN}&pretty=1")
    response = Net::HTTP.get_response(uri)
    slack_user_data = JSON.parse(response.body)["members"]

    slack_user_data.map { |data| self.new(data) }
  end

  def self.find_by_email(email)
    all.select { |m| m.email == email }.first
  end

  def self.find_by_id(id)
    all.select { |m| m.id == id }.first
  end

  def initialize(data)
    @id = data['id']
    @username = data['name']
    @email = data['profile']['email']
  end

end
