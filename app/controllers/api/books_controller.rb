class Api::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  def create
    book = Book.create(book_params)
    if book.valid?
      render json: { book: BookSerializer.new(book), status: :ok }
    else
      render json: { errors: book.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    render json: { book: BookSerializer.new(@book) }
  end

  def update
    if @book.update(book_params)
      render json: { book: BookSerializer.new(@book), message: "Updated book", status: :ok }
    else
      render json: { message: @book.errors.full_messages, status: :not_accepted}
    end
  end

  def destroy
    @book.destroy
    render json: { message: "Deleted book", status: :ok}
  end

  private

  def book_params
    params.require(:book).permit(:googleid, :title, :subtitle, :authors, :categories, :description, :language, :image_url, :published_date, :page_count, :google_average_rating, :rating_count)
  end

  def set_book
    @book = Book.find_by(id: params[:id])
  end
end
