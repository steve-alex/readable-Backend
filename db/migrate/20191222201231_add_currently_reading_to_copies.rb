class AddCurrentlyReadingToCopies < ActiveRecord::Migration[6.0]
  def change
    add_column :copies, :currently_reading, :boolean, default: false
  end
end
