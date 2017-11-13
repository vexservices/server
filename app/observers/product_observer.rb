class ProductObserver < ActiveRecord::Observer

  def after_update(product)
    refresh_publishes(product)
  end

  private

    def refresh_publishes(product)
      if store = product.store
        update_publishes(product, store.publishes.by_product(product.id))
      end
    end

    def update_publishes(product, publishes)
      return unless publishes

      publishes.update_all(
        regular_price: product.regular_price,
        price: product.price,
        updated_at: DateTime.now
      )
    end
end
