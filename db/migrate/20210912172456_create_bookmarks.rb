class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :question
      t.references :user

      t.timestamps
    end
  end
end
