class BandsController < ApplicationController
  before_action :must_be_logged_in

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to new_band_url
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to edit_band_url
    end
  end

  private

    def band_params
      params.require(:band).permit(:name)
    end
end
