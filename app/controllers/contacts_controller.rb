class ContactsController < ApplicationController
  respond_to :js

  def create
    @contact = Contact.new(contact_params)

    flash[:notice] = t('messages.created', model: Contact.model_name.human) if @contact.save
    respond_with @contact, :location => root_url
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :message, :franchise_id)
    end
end
