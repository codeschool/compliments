require "net/http"
require "uri"

class Slacker
  SLACK_TOKEN = ENV['SLACK_TOKEN']

  attr_reader :id, :username, :email, :name, :image

  def self.all
    uri = URI.parse("https://slack.com/api/users.list?token=#{SLACK_TOKEN}&pretty=1")
    response = Net::HTTP.get_response(uri)
    slack_user_data = JSON.parse(response.body)["members"]

    slack_user_data.map { |data| self.new(data) }
  end


  def self.find_by_email(email)
    all.select { |m| m.email == email }.first
  end

  def self.find_by_username(username)
    all.select { |s| s.username == username }.first
  end

  def self.find_by_id(id)
    uri = URI.parse("https://slack.com/api/users.info?token=#{SLACK_TOKEN}&user=#{id}&pretty=1")
    response = Net::HTTP.get_response(uri)
    slack_user_data = JSON.parse(response.body)["user"]

    self.new(slack_user_data)
  end

  def initialize(data)
    @id = data['id']
    @username = data['name']
    @email = data['profile']['email']
    @name = data['profile']['real_name']
    @image = data['profile']['image_192']
  end

end
