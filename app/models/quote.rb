class Quote < ActiveRecord::Base
  belongs_to :quoter, class_name: "User"
  belongs_to :quotee, class_name: "User"

  default_scope { order("created_at DESC") }

  def from?(user)
    quoter_id == user.id
  end

  def self.random
    unscoped.order("RANDOM()").first
  end
end
