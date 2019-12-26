class TimelineSerializerTest
  require "#{Rails.root}/app/serializers/review_serializer.rb"
  require "#{Rails.root}/app/serializers/progress_serializer.rb"
  
  def initialize(current_user)
    @user = current_user
  end

  def serialize_as_json
    {
      currently_reading: nil,
      posts: @user.timeline_posts.map{ |post| 
        if post.class == Progress
          {
            progress: ProgressSerializer.new(post, @user).serialize_as_json
          }
        elsif post.class == Review 
          {
            review: ReviewSerializer.new(post, @user).serialize_as_json
          }
        else
          {
            post: nil
          }
        end
      }
    }
  end

end