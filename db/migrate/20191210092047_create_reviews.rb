class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shelfBook, null: false, foreign_key: true

      t.timestamps
    end
  end
end
