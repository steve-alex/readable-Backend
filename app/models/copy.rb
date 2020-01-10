class Copy < ApplicationRecord
  belongs_to :book
  has_many :shelf_copies
  has_many :shelves, through: :shelf_copies
  has_many :updates
  has_many :progresses, through: :updates
  has_many :reviews

  def display_updates
    self.updates.reverse.map{ |update| 
      {
        created_at: update.created_at,
        time_since_upload: update.time_since_upload,
        id: update.id,
        page_number: update.page_number,
        progress_id: update.progress_id
      }
    }
  end

  def display_updates_for_progress(progress_id)
    updates = self.updates.select{ |update| update.progress_id == progress_id }.reverse
    updates.map{ |update| 
      {
        created_at: update.created_at,
        time_since_upload: update.time_since_upload,
        id: update.id,
        page_number: update.page_number,
        progress_id: update.progress_id
      }
    }
  end
end