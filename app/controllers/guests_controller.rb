class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :update, :destroy]

  def index
    @guests = Guest.all
    response_json(@guests)
  end

  def show
    response_json(@guest)
  end

  def create
    @guest = Guest.create!(guest_params)
    response_json(@guest, :created)
  end

  def update
    @guest.update(guest_params)
    head :no_content
  end

  def destroy
    @guest.destroy
    head :no_content
  end


  private

  def guest_params
    params.permit(:first_name, :last_name,
                  :email, :document_id)
  end

  def set_guest
    @guest = Guest.find(params[:id])
  end
end
