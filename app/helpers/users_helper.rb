module UsersHelper
  def user_store_helper_path(user)
    user.store_corporate? ? admin_corporate_path(user.store_id) : admin_corporate_store_path(user.store_store_id, user.store_id)
  end

  def search_seller_by_cookie
    if cookies[:seller_id]
      if seller = Seller.where(number: cookies[:seller_id]).first
        seller.name_with_number
      end
    end
  end
end
