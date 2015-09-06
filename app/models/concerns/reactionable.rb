module Reactionable
  extend ActiveSupport::Concern

  included do
    has_many :emoji_reactions, as: :reactionable
  end

  def grouped_emoji_reactions
    emoji_reactions.count_by_emoji
  end

  def has_reaction?(user, emoji)
    return false if user.nil?

    emoji_reactions.where(user_id: user.id, emoji: emoji).any?
  end
end
