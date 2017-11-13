class Store::StoreController < ApplicationController
  layout 'store'

  before_action :authenticate_user!
  before_action :check_pending

  around_filter :user_time_zone, if: :current_store

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_store
    @current_store ||= current_user.store
  end
  helper_method :current_store

  def current_corporate
    @current_corporate ||= current_store.corporate
  end
  helper_method :current_corporate

  def current_franchise
    @franchise ||= current_store.franchise if current_store.belongs_to_franchise?
  end
  helper_method :current_franchise

  private

    def user_time_zone(&block)
      Time.use_zone(current_store.time_zone, &block)
    end

    def check_pending
      return if session[:skip_check]

      if current_store.term_version < Term.version
        # Accept Term of Use
        redirect_to accept_term_path if controller_name != 'accept_terms'
      elsif current_store.setup_app_image?
        # Setup App Image
        redirect_to new_image_path if %w(images logos).exclude? controller_name
      elsif current_store.app_setup_cover?
        # Setup App Cover
        redirect_to edit_app_path if controller_name != 'apps'
      elsif current_store.setup_payment_option?
        # Setup Payment Option
        redirect_to edit_payment_path if controller_name != 'payments'
      elsif current_store.setup_payment?
        # Enter credit card information
        redirect_to new_order_path if controller_name != 'orders'
      elsif current_store.delayed_invoices?
        # Redirect to Invoice screen when store have delayed invoice
        redirect_to invoices_path if controller_name != 'invoices'
      else
        session[:skip_check] = true
      end
    end

    def user_not_authorized
      flash[:error] = t('messages.not_authorized')
      redirect_to(categories_path)
    end
end
