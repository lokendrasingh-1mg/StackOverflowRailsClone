class CreateUserVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :user_votes do |t|
      t.integer :vote_type
      t.integer :votable_id
      t.string :votable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
