class Admin::ContactsController < Admin::AdminController
  include AdminPolicies

  set_tab :contacts
  before_action :set_contact, except: [:index]

  def index
    if current_franchise.present?
      @contacts = current_franchise.contacts.order('created_at DESC')
    end

    @contacts ||= Contact.order('created_at DESC')
    @contacts   = @contacts.includes(:franchise).page(params[:page])
  end

  def show
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Contact.model_name.human) if @contact.destroy
    respond_with @contact, :location => admin_contacts_url
  end

  private

    def set_contact
      if current_franchise.present?
        @contact = current_franchise.contacts.find(params[:id])
      else
        @contact = Contact.find(params[:id])
      end
    end
end
