class Quote < ActiveRecord::Base
  belongs_to :user

  default_scope { order("created_at DESC") }

  def from?(user)
    user_id == user.id
  end
end
