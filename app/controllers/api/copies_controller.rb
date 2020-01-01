class Api::CopiesController < ApplicationController
  before_action :set_copy, only: [:show, :update, :destroy]
  require "#{Rails.root}/app/serializers/copy_serializer.rb"

  def create
    @copy = Copy.create(copy_params)
    if @copy.valid?
      render json: { copy: CopySerializer.new(@copy), status: :ok }
    else
      render json: { errors: copy.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    render json: { review: CopySerializer.new(@copy) }
  end
  
  def update
    if @copy.update(copy_params)
      render json: { copy: CopySerializer.new(@copy), message: "Ucopy review", status: :ok}
    else
      render json: { message: @copy.errors.full_messages, status: :not_accepted}
    end
  end
  
  def destroy
    @copy.destroy
    render json: { message: "Deleted copy", status: :ok}
  end
  
  private

  def copy_params
    params.require(:copy).permit(:id, :book_id, :currently_reading)
  end
  
  def set_copy
    @copy = Copy.find(params[:id])
  end

end
