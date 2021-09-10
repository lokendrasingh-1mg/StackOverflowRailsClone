class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :heading
      t.string :description
      t.integer :votes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
