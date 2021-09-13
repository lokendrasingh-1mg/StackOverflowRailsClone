class CreateUserVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :user_votes do |t|
      t.integer :vote_type
      t.references :votable, polymorphic: true
      t.references :user

      t.timestamps
    end
  end
end
