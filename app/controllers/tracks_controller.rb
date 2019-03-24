class TracksController < ApplicationController
  before_action :set_track, only: [:show, :update, :destroy]
  before_action :set_room, only: [:index, :create]
  before_action :set_guest, only: [:index, :create]

  def index
    if @room.present?
      @tracks = @room.tracks
    elsif @guest.present?
      @tracks = @guest.tracks
    else
      @tracks = Track.all
    end
    response_json(@tracks)
  end

  def create
    @track = Track.create!(track_params)
    response_json(@track, :created)
  end

  def show
    response_json(@track)
  end

  def destroy
    @track.destroy
    head :no_content
  end


  private

  def track_params
    params.permit(:guest_id,:room_id,
                  :status)
  end

  def set_track
    @track = Track.find(params[:id])
  end

  def set_room
    if params[:room_id].present?
      @room = Room.find(params[:room_id])
    end
  end

  def set_guest
    if params[:guest_id].present?
      @guest = Guest.find(params[:guest_id])
    end
  end
end
