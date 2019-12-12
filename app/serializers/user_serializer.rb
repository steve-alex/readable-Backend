class UserSerializer < ActiveModel::Serializer
  attributes :id, :fullname, :username, :email, :gender, :city, :about
  has_many :shelves
  has_many :shelf_books
  has_many :reviews
  has_many :progresses

  def fullname
    if object.fullnameviewable
      return object.fullname
    end
    nil
  end

  def city
    if object.cityviewable
      return object.city
    end
    nil
  end
end