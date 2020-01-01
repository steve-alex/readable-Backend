class Api::ShelvesController < ApplicationController
  before_action :set_shelf, only: [:show, :update, :destroy]
  require "#{Rails.root}/app/serializers/shelf_serializer.rb"


  def create
    shelf = Shelf.create(shelf_params)
    if shelf.valid?
      render json: { shelves: shelf, status: :ok }
    else
      render json: { errors: shelf.errors.full_messages, status: :not_accepted }
    end
  end
  
  def show
    if @shelf
      render json: { shelf: ShelfSerializer.new(@shelf, @current_user).serialize_as_json, status: :ok }
    else
      render json: { errors: @shelf.errors.full_messages, status: :not_accepted }
    end
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
    @shelf = Shelf.find(params[:shelf_id])
    @book = Book.find_by(google_id: params[:book][:google_id])
    unless @book
      @book = Book.create(book_params)
    end
    @copy = @current_user.copies.find{ |copy| copy.book_id == @book.id }
    unless @copy
      @copy = Copy.create(book_id: @book.id)
    end
    if @shelf.copies.include?(@copy)
      render json: { errors: "#{@copy.book.title} is already in #{@shelf.name}"}
    else
      if @shelf && @book && @copy
        @shelf.copies << @copy
        render json: { shelf: ShelfSerializer.new(@shelf, @current_user).serialize_as_json, message: "#{@book.title} has been added to #{@shelf.name}", status: :ok }
      else
        render json: { errors: @shelf.errors.full_messages, status: :not_accepted }
      end
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
    @shelf = Shelf.find(params[:id])
  end

end