class Api::ShelvesController < ApplicationController
  before_action :set_shelf, only: [:show, :update, :destroy]

  def create
    shelf = Shelf.create(shelf_params)
    if shelf.valid?
      render json: { shelves: shelf, status: :ok }
    else
      render json: { errors: shelf.errors.full_messages, status: :not_accepted }
    end
  end
  
  def show
    render json: @shelf
  end

  def update
    if @shelf.update(shelf_params)
      render json: { message: "Shelf has been updated", status: :ok }
    else
      render json: { shelf: @shelf, message: @shelf.errors.messages, status: :not_accepted }
    end
  end

  def destroy
    @shelf.destroy
    render json: { message: "Deleted shelf", status: :ok}
  end

  def add_book
    shelf = Shelf.find(params[:shelfId])
    book = Book.find_by(google_id: params[:book][:google_id])
    if !book
      book = Book.create(book_params)
    end
    
    if shelf.books.include?(book)
      render json: { errors: "#{book.title} is already in #{shelf.name}"}
    else
      shelf.books << book
      render json: { message: "#{book.title} has been added to #{shelf.name}"}
    end
  end

  private

  def shelf_params
    params.require(:shelf).permit(:name, :user_id)
  end

  def book_params
    params.require(:book).permit(:google_id, :title, :subtitle, :authors, :categories, :description, :language, :image_url, :published_date, :page_count, :google_average_rating, :rating_count)
  end

  def set_shelf
    @shelf = Shelf.find_by(id: params[:id])
  end

end