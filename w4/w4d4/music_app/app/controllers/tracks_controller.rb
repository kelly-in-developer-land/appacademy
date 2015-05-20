class TracksController < ApplicationController
  before_action :must_be_logged_in

  def create
    @track = Track.new(track_params)
    @current_album = Album.find(track_params[:album_id])
    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url(@track.album)
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
  end

  def edit
    @track = Track.find(params[:id])
    @band_albums = @track.band.albums.all
    @current_album = @track.album
    render :edit
  end

  def index
    @album = Album.find(params[:album_id])
    @tracks = @album.tracks
    render :index
  end

  def new
    @current_album = Album.find(params[:album_id])
    @band_albums = @current_album.band.albums
    render :new
  end

  def show
    @track = Track.find(params[:id])
    @album = Album.find(@track.album_id)
    render :show
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to edit_track_url
    end
  end

  private

    def track_params
      params.require(:track).permit(:title, :status, :lyrics, :album_id)
    end

end
