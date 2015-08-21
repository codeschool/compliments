class Compliment < ActiveRecord::Base
  belongs_to :complimenter, class_name: "User"
  belongs_to :complimentee, class_name: "User"

  after_create :notify

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
end
