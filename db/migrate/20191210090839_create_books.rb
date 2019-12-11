class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :googleid
      t.string :title
      t.string :subtitle
      t.string :authors
      t.string :categories
      t.string :description
      t.string :langugage
      t.string :image_url
      t.string :published_date
      t.string :page_count
      t.string :google_average_rating
      t.string :rating_count
      
      t.timestamps
    end
  end
end
