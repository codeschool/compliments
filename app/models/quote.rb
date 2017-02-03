class Quote < ActiveRecord::Base
  belongs_to :quoter, class_name: "User"
  belongs_to :quotee, class_name: "User"

  validates :quoter, presence: true
  validates :quotee, presence: true

  default_scope { order("created_at DESC") }

  delegate :name, to: :quotee, prefix: true
  delegate :name, to: :quoter, prefix: true

  delegate :image, to: :quotee, prefix: true
  delegate :image, to: :quoter, prefix: true

  delegate :slack_id, to: :quotee, prefix: true
  delegate :slack_id, to: :quoter, prefix: true

  delegate :slack_username, to: :quotee, prefix: true
  delegate :slack_username, to: :quoter, prefix: true

  after_create :post_to_slack

  def from?(user)
    quoter_id == user.id
  end

  def self.random
    unscoped.order("RANDOM()").first
  end

  private

  def post_to_slack
    Slack.notify_quote(self)
  end
end
