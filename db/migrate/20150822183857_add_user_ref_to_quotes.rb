class AddUserRefToQuotes < ActiveRecord::Migration
  def change
    add_reference :quotes, :user, index: true, foreign_key: true
  end
end
