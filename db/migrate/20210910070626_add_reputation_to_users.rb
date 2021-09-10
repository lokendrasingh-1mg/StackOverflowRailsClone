class AddReputationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reputation, :int
  end
end
