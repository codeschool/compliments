class AddQuoterIdToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :quoter_id, :integer
  end
end
