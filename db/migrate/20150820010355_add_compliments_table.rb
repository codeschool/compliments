class AddComplimentsTable < ActiveRecord::Migration
  def change
    create_table :compliments do |t|
      t.integer :complimenter_id, null: false
      t.integer :complimentee_id, null: false
      t.text :text
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
