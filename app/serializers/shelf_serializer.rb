class ShelfSerializer

  def initialize(shelf)
    @shelf = shelf
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
      copies: @shelf.copies,
      books: @shelf.display_books
    }
  end
end