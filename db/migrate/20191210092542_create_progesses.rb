class CreateProgesses < ActiveRecord::Migration[6.0]
  def change
    create_table :progesses do |t|
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :shelfBook, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
