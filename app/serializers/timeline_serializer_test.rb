class TimelineSerializerTest
  
  def initialize(current_user)
    @user = current_user
  end

  def serialize_as_json
    {
      timeline_posts: [
        @user.timeline_posts.map{|post| 
          {
            post: post,
            book: {
              book_id: post.book.id,
              title: post.book.title,
              subtitle: post.book.subtitle,
              categories: post.book.categories,
              description: post.book.description,
              image_url: post.book.image_url,
              page_count: post.book.page_count
            },
            user: {
              id: post.user.id,
              username: post.user.username
            },
            comments: {post.comments.map{|comment|
              {
                comment: comment,
                user: {
                  id: comment.user.id,
                  username: comment.user.username
                }
              }}
            },
            likes: {post.likes.map{|like|
              {
                like: like,
                user: {
                  id: like.user.id,
                  username: like.user.username
                }
              }}
            }
          }
        }
      ]
    }
        
  end

end