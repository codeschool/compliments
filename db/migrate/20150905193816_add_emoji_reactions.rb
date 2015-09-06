class AddEmojiReactions < ActiveRecord::Migration
  def change
    create_table :emoji_reactions do |t|
      t.string :emoji
      t.references :user, null: false
      t.references :reactionable, polymorphic: true, index: true, null: false

      t.timestamps
    end
  end
end
