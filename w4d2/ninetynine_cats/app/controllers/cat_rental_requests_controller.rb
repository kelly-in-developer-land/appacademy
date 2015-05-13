class CatRentalRequestsController < ApplicationController

  def index
    render :index
  end

  def new
    @cats = Cat.all
    @requested_cat = Cat.first
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_url(@request.cat_id)
    else
      flash.now[:errors] = @request.errors.full_messages
      @requested_cat = Cat.find(@request.cat_id)
      @cats = Cat.all
      render :new
    end
  end

  private

    def request_params
      params.require(:request).permit(:cat_id, :start_date, :end_date)
    end

end
