class CopySerializer
  def initialize(copy)
    @copy = copy
  end

  def serialize_as_json
    {
      id: @copy.id,
      book: @copy.book
    }
  end
end