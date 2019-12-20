class AddPublishedToProgresses < ActiveRecord::Migration[6.0]
  def change
    add_column :progresses, :published, :boolean
  end
end
