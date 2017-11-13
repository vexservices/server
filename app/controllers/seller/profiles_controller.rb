class Seller::ProfilesController < Seller::SellerController
  set_tab :profile

  before_action :set_seller

  def edit
    if current_seller.bank.blank? && current_seller.is_brazilian?
      current_seller.build_bank
    end
  end

  def update
    if params[:seller][:password].blank?
      params[:seller].delete("password")
      params[:seller].delete("password_confirmation")
    end

    if @seller.update_attributes(seller_params)
      flash[:notice] = t('flash_messages.updated', model: t('titles.seller_profile'))
      sign_in @seller, :bypass => true
    end

    respond_with @seller, location: edit_seller_profile_url
  end

  private
    def set_seller
      @seller = current_seller
    end

    def seller_params
      params.require(:seller).permit(
        :name, :phone, :cell_phone, :email, :seller_id,
        :password_confirmation, :password, :document,
        address_attributes: [ :id, :country, :state, :city, :street, :zip ],
        bank_attributes: [ :number, :agency, :name ]
      )
    end
end
