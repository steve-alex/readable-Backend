class CreateProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :progresses do |t|
      t.integer :current_page
      t.integer :total_pages
      t.references :user, null: false, foreign_key: true
      t.references :shelf_book, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end