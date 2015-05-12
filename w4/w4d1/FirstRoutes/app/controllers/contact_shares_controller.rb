class ContactSharesController < ApplicationController

  def create
    @contact_shares = ContactShare.new
    render json: @contact_share
  end

  def destroy
    @contact_share = ContactShare.find(params[:id])
    @contact_share.destroy
    render json: @contact_share
  end

  # private
  #
  # def contact_params
  #   params.require(:contact_share).permit(:contact_id, :user_id)
  # end

end
