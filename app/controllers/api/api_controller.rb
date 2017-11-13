class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  around_filter :user_time_zone, if: :current_store
  before_filter :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_store
    @current_store ||= current_user.store if current_user
  end
  helper_method :current_store

  def current_corporate
    @current_corporate ||= current_store.corporate if current_store
  end
  helper_method :current_corporate

  private

    def user_time_zone(&block)
      Time.use_zone(current_store.time_zone, &block)
    end

    def user_not_authorized
      render json: { error: 'Not authorized.' }, status: 401
    end

    def record_not_found
      render json: { error: 'Record not found.' }, status: 401
    end

    def set_locale
      I18n.locale = :api
    end
end
