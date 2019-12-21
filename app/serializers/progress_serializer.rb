class ProgressSerializer
  
  def initialize(progress)
    @progress = progress
  end

  def serializer_as_json
    {
      id: @progress.id,
      user_id: @progress.user_id,
      content: @progress.content,
      published: @progress.published,
      updates: @progress.display_updates_by_book(),
      user: {
        id: @progress.user.id,
        username: @progress.user.username,
        avatar: @progress.user.avatar
      },
      likes: @progress.likes,
      comments: @progress.display_comments,
      created_at: @progress.created_at
    }
  end
  
end