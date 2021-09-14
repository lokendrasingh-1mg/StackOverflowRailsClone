class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user
      t.references :commentable, polymorphic: true
      t.string :content
      t.integer :votes, default: 0
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
