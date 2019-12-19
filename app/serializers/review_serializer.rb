class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :sentiment, :user_id, :book_id, :user
  has_many :comments
  has_many :likes

  def user
    user = object.user
   {
     id: user.id,
     fullname: user.fullname,
     username: user.username,
     created_at: user.created_at,
     updated_at: user.updated_at
   }
  end

end