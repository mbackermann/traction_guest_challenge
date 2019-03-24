class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update, :destroy]

  def index
    @rooms = Room.all
    response_json(@rooms)
  end

  def show
    response_json(@room)
  end

  def create
    @room = Room.create!(room_params)
    response_json(@room, :created)
  end

  def update
    @room.update(room_params)
    head :no_content
  end

  def destroy
    @room.destroy
    head :no_content
  end


  private

  def room_params
    params.permit(:name)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
