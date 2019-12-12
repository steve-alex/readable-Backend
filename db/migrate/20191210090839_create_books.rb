class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :google_id
      t.string :title
      t.string :subtitle
      t.string :authors
      t.string :publisher
      t.string :categories
      t.string :description
      t.string :language
      t.string :image_url
      t.string :published_date
      t.string :page_count
      t.string :google_average_rating
      t.string :rating_count
      
      t.timestamps
    end
  end
end