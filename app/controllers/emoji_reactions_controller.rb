class EmojiReactionsController < ApplicationController
  def create
    @emoji_reaction = find_compliment.emoji_reactions.new(emoji_reaction_params)

    if @emoji_reaction.save
      render json: { count: find_compliment.grouped_emoji_reactions[find_emoji].to_i }, status: 200
    else
      render json: { errors: @emoji_reaction.errors.full_messages.to_sentence }, status: 500
    end
  end

  def destroy
    @emoji_reaction = find_emoji_reaction

    if @emoji_reaction && @emoji_reaction.destroy
      render json: { count: find_compliment.grouped_emoji_reactions[find_emoji].to_i }, status: 200
    else
      render json: { errors: "Unable to remove emoji_reaction. :(" }, status: 500
    end
  end

  private

  def find_compliment
    Compliment.find(params[:compliment_id])
  end

  def find_emoji_reaction
    find_compliment.emoji_reactions.where(user_id: current_user.id).first
  end

  def find_emoji
    Emoji.find_by_alias(params[:emoji])
  end

  def emoji_reaction_params
    { user_id: current_user.id, emoji: params[:emoji] }
  end

end
