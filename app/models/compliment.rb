class Compliment < ActiveRecord::Base
  belongs_to :complimenter, class_name: "User"
  belongs_to :complimentee, class_name: "User"
  has_many :emoji_reactions, as: :reactionable
  has_many :uphearts, inverse_of: :compliment

  after_create :notify
  after_create :create_complimenter_upheart

  default_scope { order("created_at DESC") }

  def self.public
    where(private: false)
  end

  def self.random
    unscoped.order("RANDOM()").first
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

  def create_complimenter_upheart
    self.uphearts.create(user_id: complimenter.id)
  end
end
