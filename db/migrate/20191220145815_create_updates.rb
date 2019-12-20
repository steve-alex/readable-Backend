class CreateUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :updates do |t|
      t.integer :page_number
      t.references :progress, null: false, foreign_key: true
      t.references :copy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
