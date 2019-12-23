class UpdateSerializer

  def initialize(update)
    @update = update
  end

  def serialize_as_json
    {
      id: @update.id,
      page_count: @update.page_number,
      copy_id: @update.copy_id,
      progress_id: @update.progress_id,
      created_at: @update.created_at,
      user_id: @update.progress.user.id
    }
  end

end