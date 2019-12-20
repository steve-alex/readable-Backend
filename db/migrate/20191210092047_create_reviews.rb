class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :summary
      t.string :content
      t.integer :rating
      t.integer :sentiment
      t.references :user, null: false, foreign_key: true
      t.references :copy, null: false, foreign_key: true

      t.timestamps
    end
  end
end