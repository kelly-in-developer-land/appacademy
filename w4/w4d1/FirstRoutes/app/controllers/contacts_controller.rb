class ContactsController < ApplicationController

  def create
    @contact = Contact.new
    render json: @contact
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path
  end

  def index
    @user = User.find(params[:user_id])
    @contacts = @user.contacts + @user.shared_contacts
    render json: @contacts
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update!(contact_params)
      redirect_to contact_path(@contact)
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email)
  end

end
