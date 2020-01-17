class ShelfSerializer

  def initialize(shelf, current_user)
    @shelf = shelf
    @current_user = current_user
  end

  def serialize_as_json
    {
      id: @shelf.id,
      name: @shelf.name,
      user: {
        id: @shelf.user.id,
        username: @shelf.user.username,
        avatar: @shelf.user.avatar
      },
      books: @shelf.display_books(@current_user),
      latest_copy: @shelf.copies[-1]
    }
  end
  
end