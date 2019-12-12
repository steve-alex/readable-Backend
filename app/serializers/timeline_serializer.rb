class TimelineSerializer < ActiveModel::Serializer
  attributes :user

  def user
    current_user = object
    {
      id: current_user.id,
      fullname: current_user.id,
      username: current_user.username,
      email: current_user.email,
      gender: current_user.gender,
      city: current_user.city,
      about: current_user.about,
      currently_reading: current_user.currently_reading_books,
      timeline_posts: current_user.timeline_posts
    }
  end

end