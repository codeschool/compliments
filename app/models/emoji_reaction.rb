class EmojiReaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :reactionable, polymorphic: true

  validates :emoji, inclusion: { in: Emoji.all.map(&:name) }
  validates :reactionable, presence: true
  validates_uniqueness_of :emoji, scope: [:user, :reactionable], message: "has already been set on item."

  def self.count_by_emoji
    self.group(:emoji).count.inject({}) do |h, (emoji, count)|
      h[Emoji.find_by_alias(emoji)] = count
      h
    end
  end
end
