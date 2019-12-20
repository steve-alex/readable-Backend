class ShelfCopy < ApplicationRecord
  belongs_to :shelf
  belongs_to :copy
end
