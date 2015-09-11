class UpdateQuotesTable < ActiveRecord::Migration
  def change
    remove_reference :quotes, :user
    remove_column :quotes, :quoter_id
    add_column :quotes, :quoter_id, :integer, null: false
    add_column :quotes, :quotee_id, :integer, null: false
  end
end
