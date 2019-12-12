class ShelfBook < ApplicationRecord
  belongs_to :book
  belongs_to :shelf
  has_many :reviews
  has_many :progresses

  # validates :currently_reading, {
  #   presence: true
  # }
 end
