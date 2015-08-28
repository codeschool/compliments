class Upheart < ActiveRecord::Base
  belongs_to :user
  belongs_to :compliment

  validates_uniqueness_of :user, scope: :compliment
end
