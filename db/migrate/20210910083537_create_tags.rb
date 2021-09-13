class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.index :name, unique: true

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
