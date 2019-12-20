class CreateProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :progresses do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end