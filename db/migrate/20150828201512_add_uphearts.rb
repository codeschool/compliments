class AddUphearts < ActiveRecord::Migration
  def change
    create_table :uphearts do |t|
      t.timestamps
    end

    add_reference :uphearts, :user, index: true
    add_reference :uphearts, :compliment, index: true
  end
end
