class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.integer :votes
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end
