class Seller::SellerController < ApplicationController
  layout 'seller'
  before_action :authenticate_seller!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_franchise
    @franchise ||= current_seller.franchise if current_seller.belongs_to_franchise?
  end
  helper_method :current_franchise

  private

    def user_not_authorized
      flash[:error] = t('errors.access_denied')
      redirect_to(seller_root_path)
    end
end
