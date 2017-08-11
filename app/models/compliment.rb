class Compliment < ActiveRecord::Base
  belongs_to :complimenter, class_name: "User"
  belongs_to :complimentee, class_name: "User"
  has_many :uphearts, inverse_of: :compliment

  after_create :post_to_slack
  after_create :create_complimenter_upheart

  delegate :name, to: :complimentee, prefix: true
  delegate :name, to: :complimenter, prefix: true

  delegate :image, to: :complimentee, prefix: true
  delegate :image, to: :complimenter, prefix: true

  delegate :slack_id, to: :complimentee, prefix: true
  delegate :slack_id, to: :complimenter, prefix: true

  delegate :slack_username, to: :complimentee, prefix: true
  delegate :slack_username, to: :complimenter, prefix: true


  default_scope { order(created_at: :desc) }

  def self.public
    where(private: false)
  end

  def self.active
    joins("JOIN users AS complimentee ON complimentee.id = complimentee_id").
      joins("JOIN users AS complimenter ON complimenter.id = complimenter_id").
      where(complimentee: { active: true }).
      where(complimenter: { active: true })
  end

  def self.recent
    where("compliments.created_at > ?", 1.month.ago)
  end

  def self.random
    unscoped.active.recent.order("RANDOM()").first
  end

  def from?(user)
    user == complimenter
  end

  def notify
    ComplimentMailer.notify(self).deliver_later
  end

  def uphearted_by?(user)
    return false if user.nil?

    uphearts.where(user_id: user.id).any?
  end

  def upheart_count
    uphearts.size
  end

  private

  def post_to_slack
    Slack.notify_compliment(self)
  end

  def create_complimenter_upheart
    self.uphearts.create(user_id: complimenter.id)
  end
end
