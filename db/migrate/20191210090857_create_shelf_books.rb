class CreateShelfBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :shelf_books do |t|
      t.boolean :currently_reading, default: false
      t.references :book, null: false, foreign_key: true
      t.references :shelf, null: false, foreign_key: true

      t.timestamps
    end
  end
end