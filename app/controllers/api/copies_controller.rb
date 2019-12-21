class Api::CopiesController < ApplicationController
  before_action :set_copy, only: [:show, :update, :destroy]
  require "#{Rails.root}/app/serializers/copy_serializer.rb"

  def create
    current_user = set_current_user
    copy = Copy.create(copy_params)
    if copy.valid?
      render json: { copy: CopySerializer.new(copy), status: :ok }
    else
      render json: { errors: copy.errors.full_messages, status: :not_accepted }
    end
  end

  def show
    render json: { review: CopySerializer.new(@review) }
  end
  
  def update
    if @copy.update(copy_params)
      render json: { copy: CopySerializer.new(@review), message: "Ucopy review", status: :ok}
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
    params.require(:copy).permit(:book_id)
  end
  
  def set_copy
    @copy = copy.find_by(id: params[:id])
  end

end
