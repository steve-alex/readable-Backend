class ShelfBookSerializer < ActiveModel::Serializer
  attributes :currently_reading, :book_id, :shelf_id
end