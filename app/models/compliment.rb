class Compliment < ActiveRecord::Base
  belongs_to :complimenter, class_name: "User"
  belongs_to :complimentee, class_name: "User"

  def self.public
    where(private: false)
  end

  def from?(user)
    user == complimenter
  end
end
