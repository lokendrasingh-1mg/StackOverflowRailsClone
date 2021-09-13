class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, index: { unique: true }

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
