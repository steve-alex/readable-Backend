class TimelineSerializerTest
  require "#{Rails.root}/app/serializers/review_serializer.rb"
  require "#{Rails.root}/app/serializers/progress_serializer.rb"
  
  def initialize(current_user)
    @user = current_user
  end

  def serialize_as_json
    {
      posts: @user.timeline_posts.map{ |post| 
        if post.class == Progress
          {
            progress: ProgressSerializer.new(post).serialize_as_json
          }
        else
          {
            review: ReviewSerializer.new(post).serialize_as_json
          }
        end
      }
    }
  end

end