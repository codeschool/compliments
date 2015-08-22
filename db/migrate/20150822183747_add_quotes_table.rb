class AddQuotesTable < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :text

      t.timestamps
    end
  end
end
