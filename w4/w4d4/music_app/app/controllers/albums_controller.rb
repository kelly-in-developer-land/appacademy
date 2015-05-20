class AlbumsController < ApplicationController
  before_action :must_be_logged_in

  def create
    @album = Album.new(album_params)
    @current_band = Band.find(album_params[:band_id])
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_album_url
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    @current_band = @album.band
    render :edit
  end

  def index
    @band = Band.find(params[:band_id])
    @albums = @band.albums
    render :index
  end

  def new
    @current_band = Band.find(params[:band_id])
    @bands = Band.all
    render :new
  end

  def show
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
    render :show
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to edit_album_url
    end
  end

  private

    def album_params
      params.require(:album).permit(:name, :set, :band_id)
    end

end
