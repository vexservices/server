module PricesHelper
  def link_to_create_or_edit_price(product, price)
    url = price ? edit_product_price_path(product, price) : new_product_price_path(product)

    link_to_edit url
  end
end
