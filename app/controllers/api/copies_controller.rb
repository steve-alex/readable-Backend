class Api::CopiesController < ApplicationController
  before_action :set_copy, only: [:show, :update, :destroy]
  require "#{Rails.root}/app/serializers/copy_serializer.rb"

  def create
    @copy = Copy.create(copy_params)
    if @copy.valid?
      render json: {copy: CopySerializer.new(@copy), status: 201}
    else
      render json: {errors: copy.errors.full_messages, status: 400}
    end
  end

  def show
    if @copy
      render json: {copy: CopySerializer.new(@copy), status: 200}
    else
      render json: {message: @copy.errors.full_messages, status: 400}
    end
  end
  
  def update
    if @copy.update(copy_params)
      render json: {copy: CopySerializer.new(@copy), status: 200}
    else
      render json: {message: @copy.errors.full_messages, status: :400}
    end
  end

  private

  def copy_params
    params.require(:copy).permit(:id, :book_id, :currently_reading)
  end
  
  def set_copy
    @copy = Copy.find(params[:id])
  end

end
