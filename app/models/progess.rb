class Progess < ApplicationRecord
  belongs_to :user
  belongs_to :shelfBook
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable
end
