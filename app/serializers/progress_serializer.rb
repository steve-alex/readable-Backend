class ProgressSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :shelf_book_id
  belongs_to :user
  belongs_to :shelf_book
  has_many :likes
  has_many :comments
end