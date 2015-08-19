class AddUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :image

      t.timestamps
    end
  end
end
