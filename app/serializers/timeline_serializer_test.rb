class TimelineSerializerTest
  
  def initialize(current_user)
    @user = current_user
  end

  # def serialize_as_json
  #   {
  #     timeline_posts: 
  #       @user.timeline_posts.map{|post| 
  #         { 
  #           content: post.content,
  #           created_at: post.created_at,
  #           id: post.id,
  #           rating: post.rating,
  #           sentiment: post.sentiment,
  #           updated_at: post.updated_at,
  #           book: {
  #             book_id: post.book.id,
  #             title: post.book.title,
  #             subtitle: post.book.subtitle,
  #             categories: post.book.categories,
  #             description: post.book.description,
  #             image_url: post.book.image_url,
  #             page_count: post.book.page_count
  #           },
  #           user: {
  #             id: post.user.id,
  #             username: post.user.username
  #           },
  #           comments: post.comments.map{|comment|
  #             {
  #               content: comment.content,
  #               created_at: comment.created_at,
  #               user: {
  #                 id: comment.user.id,
  #                 username: comment.user.username
  #               },
  #               likes: comment.likes
  #             }
  #           },
  #           likes: post.likes.map{|like|
  #             {
  #               like: like,
  #               user: {
  #                 id: like.user.id,
  #                 username: like.user.username
  #               }
  #             }
  #           }
  #         }
  #       }
  #   }
  # end

  def serialize_as_json
    {
      timeline_posts: @user.timeline_posts.map{ |post| 
        if post.class == Progress
          return ProgressSerializer.new(post).serialize_as_json
        else
          return ReviewSerializer.new(post).serialize_as_json
        end
      }
    }
  end

end