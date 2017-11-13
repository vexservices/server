class PriceObserver < ActiveRecord::Observer

  def after_save(price)
    if price.regular_price_changed? || price.price_changed?
      product = price.product
      store   = price.store

      if product && price
        publishes = store.publishes.by_product(product.id)

        update_publishes(price, publishes)
      end
    end
  end

  private

    def update_publishes(price, publishes)
      return unless publishes

      publishes.update_all(
        regular_price: price.regular_price,
        price: price.price
      )
    end
end
