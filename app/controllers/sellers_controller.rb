class SellersController < ApplicationController
  def show
    cookies[:seller_id] = params[:id]

    redirect_to new_user_registration_path
  end
end
