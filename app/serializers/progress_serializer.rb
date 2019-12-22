class ProgressSerializer
  
  def initialize(progress)
    @progress = progress
  end

  def serialize_as_json
    {
      id: @progress.id,
      user_id: @progress.user_id,
      content: @progress.content,
      published: @progress.published,
      updates: @progress.display_updates_by_book(),
      user: {
        id: @progress.user.id,
        username: @progress.user.username,
        avatar: @progress.user.get_avatar_url
      },
      likes: @progress.likes,
      comments: @progress.display_comments,
      created_at: @progress.created_at
    }
  end
  
end