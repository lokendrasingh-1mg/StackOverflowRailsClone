class CreateUservotes < ActiveRecord::Migration[6.1]
  def change
    create_table :uservotes do |t|
      t.integer :value
      t.integer :votable_id
      t.string :votable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
