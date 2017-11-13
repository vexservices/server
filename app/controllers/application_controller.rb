class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html
  layout :layout_by_resource

  before_filter :set_locale

  def current_franchise
    if request.subdomain.present? && request.subdomain != 'www'
      @current_franchise ||= Franchise.where(subdomain: request.subdomain).first
    else
      @current_franchise ||= Franchise.where(domain: request.domain).first
    end
  end
  helper_method :current_franchise

  def current_corporate
    nil
  end
  helper_method :current_corporate

  protected

    # Set the layout by controller
    def layout_by_resource
      if devise_controller?
        "login"
      else
        'application'
      end
    end

    def after_sign_in_path_for(resource)
      if resource.is_a?(User)
        categories_url
      else
        super
      end
    end

    def after_sign_out_path_for(resource)
      session[:skip_check] = nil

      if resource == :admin
        new_admin_session_path
      else
        root_path
      end
    end

    def set_locale
      if Rails.env.test?
        I18n.locale = :en
      elsif params[:locale]
        I18n.locale = params[:locale]
      elsif session[:locale]
        I18n.locale = session[:locale]
      else
        I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
      end

      session[:locale] = I18n.locale
    end

    def default_url_options(options = {})
      { locale: I18n.locale }
    end

    def user_not_authorized
      flash[:error] = t('messages.not_authorized')
      redirect_to(request.referrer || root_path)
    end
end
