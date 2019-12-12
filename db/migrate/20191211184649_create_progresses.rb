class CreateProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :progresses do |t|
      t.integer :status
      t.references :user, null: false, foreign_key: true
      # t.integer :shelf_book_id
      t.references :shelf_book, null: false, foreign_key: true
      
      t.timestamps
    end
    # add_index :progresses, :shelf_book_id
  end
end