class User < ActiveRecord::Base

  validates :email, presence: true

  def to_s
    self.name || self.email
  end

end
