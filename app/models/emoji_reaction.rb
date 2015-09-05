class EmojiReaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :reactionable, polymorphic: true

  validates :emoji, inclusion: { in: Emoji.all.map(&:name) }
  validates :reactionable, presence: true
  validates_uniqueness_of :emoji, scope: [:user, :reactionable], message: "has already been set on item."
end
