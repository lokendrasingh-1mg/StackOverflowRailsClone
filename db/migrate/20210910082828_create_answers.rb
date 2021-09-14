class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :user
      t.references :question
      t.text :content
      t.integer :votes, default: 0

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
