class Api::BooksController < ApplicationController
  before_action :set_book, only: [:show, :find_or_create]
  require "#{Rails.root}/app/apis/client.rb"
  require "#{Rails.root}/app/serializers/book_profile_serializer.rb"
  require "#{Rails.root}/app/serializers/book_serializer.rb"

  def create
    book = Book.create(book_params)
    if book.valid?
      render json: {book: BookSerializer.new(book).serialize_as_json, status: 201}
    else
      render json: {errors: book.errors.full_messages, status: 400}
    end
  end

  def show
    if @book 
      render json: {book: BookProfileSerializer.new(@book, @current_user).serialize_as_json, status: 200}
    else
      render json: {errors: @book.errors.full_messages, status: 400}
    end
  end

  def search
    search_results = Client.new(params[:query], params[:method]).get_search_data
    if search_results
      render json: {results: search_results, status: 200}
    else
      render json: {errors: "Unable to perform search", status: 400}
    end
  end

  def find_or_create
    unless @book
      @book = Book.create(book_params)
    end
    render json: {book: BookProfileSerializer.new(@book, @current_user).serialize_as_json, status: 200}
  end

  private

  def book_params
    params.require(:book).permit(:google_id, :title, :subtitle, :authors, :categories, :description, :language, :image_url, :published_date, :page_count, :google_average_rating, :rating_count)
  end

  def set_book
    @book = Book.find(params[:id]) || Book.find_by(google_id: params[:google_id])
  end
end
