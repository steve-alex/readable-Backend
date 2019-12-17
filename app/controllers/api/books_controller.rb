class Api::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]
  require "#{Rails.root}/app/apis/client.rb"


  def create
    book = Book.create(book_params)
    if book.valid?
      render json: { book: BookSerializer.new(book), status: :ok }
    else
      render json: { errors: book.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    if @book 
      render json: { book: BookSerializer.new(@book) }
    else
      render json: { errors: @book.errors.full_messages, status: :not_accepted}
    end
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

  def search
    search_results = Client.new(params[:query]).get_search_data
    render json: { results: search_results, status: :ok}
  end

  def find_or_create
    @book = Book.find_by(google_id: params[:book][:google_id])
    if @book
      render json: { book: BookSerializer.new(@book) }
    else
      @book = Book.create(book_params)
      render json: { book: BookSerializer.new(@book), status: :ok }
    end
  end

  private

  def book_params
    params.require(:book).permit(:google_id, :title, :subtitle, :authors, :categories, :description, :language, :image_url, :published_date, :page_count, :google_average_rating, :rating_count)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
