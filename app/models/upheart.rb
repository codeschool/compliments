class Upheart < ActiveRecord::Base
  belongs_to :user
  belongs_to :compliment

  validates_uniqueness_of :compliment, scope: :user, message: "has already been uphearted."
end
