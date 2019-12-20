class CreateShelfCopies < ActiveRecord::Migration[6.0]
  def change
    create_table :shelf_copies do |t|
      t.references :shelf, null: false, foreign_key: true
      t.references :copy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
