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
    render json: @user
  end

  def update
    if @shelf.update(shelf_params)
      render json: { message: "Shelf has been updated", status: :ok }
    else
      render json: { message: @shelf.errors.messages, status: :not_accepted }
    end
  end

  def destroy
    @shelf.destroy
    render json: { message: "Deleted shelf", status: :ok}
  end

  private

  def shelf_params
    params.require(:shelf).permit(:name, :user_id)
  end

  def set_shelf
    @shelf = Shelf.find_by(id: params[:id])
  end

end