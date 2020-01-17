class TimelineSerializer
  require "#{Rails.root}/app/serializers/review_serializer.rb"
  require "#{Rails.root}/app/serializers/progress_serializer.rb"
  
  def initialize(current_user, userShowPage=false)
    @user = current_user
    @userShowPage = userShowPage
  end

  def serialize_as_json
    @posts = get_posts()
    {
      posts: @posts.map{ |post| 
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

  def get_posts
    @userShowPage ? @user.posts : @user.timeline_posts
  end

end