class Compliment < ActiveRecord::Base
  belongs_to :complimenter, class_name: "User"
  belongs_to :complimentee, class_name: "User"
  has_many :uphearts, inverse_of: :compliment

  after_create :notify
  after_create :post_to_slack
  after_create :create_complimenter_upheart

  delegate :name, to: :complimentee, prefix: true
  delegate :name, to: :complimenter, prefix: true

  default_scope { order("created_at DESC") }

  def self.public
    where(private: false)
  end

  def self.active
    joins("JOIN users AS complimentee ON complimentee.id = complimentee_id").
      joins("JOIN users AS complimenter ON complimenter.id = complimenter_id").
      where(complimentee: { active: true }).
      where(complimenter: { active: true })
  end

  def self.random
    unscoped.active.order("RANDOM()").first
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
    uphearts.count
  end

  private

  def post_to_slack
    Slack.notify_compliment(self)
  end

  def create_complimenter_upheart
    self.uphearts.create(user_id: complimenter.id)
  end
end
