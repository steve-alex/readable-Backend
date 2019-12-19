class Api::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]
  require "#{Rails.root}/app/apis/client.rb"
  require "#{Rails.root}/app/serializers/book_serializer_test.rb"

  def create
    book = Book.create(book_params)
    if book.valid?
      render json: { book: BookSerializer.new(book), status: :ok }
    else
      render json: { errors: book.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    current_user = set_current_user
    if @book 
      render json: { book: BookSerializerTest.new(@book, current_user).serialize_as_json  }
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
    current_user = set_current_user
    @book = Book.find_by(google_id: params[:book][:google_id])
    if @book
      render json: { book: BookSerializerTest.new(@book, current_user).serialize_as_json, status: :ok}
    else
      @book = Book.create(book_params)
      render json: { book: BookSerializerTest.new(@book, current_user).serialize_as_json, status: :ok}
    end
  end

  private

  def book_params
    params.require(:book).permit(:google_id, :title, :subtitle, :authors, :categories, :description, :language, :image_url, :published_date, :page_count, :google_average_rating, :rating_count)
  end

  def set_book
    @book = Book.find(params[:id]) || Book.find_by(google_id: params[:google_id])
  end
end
