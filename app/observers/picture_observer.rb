class PictureObserver < ActiveRecord::Observer

  def after_create(picture)
    update_publishes(picture.imageable_id) if picture.product?
  end

  def after_destroy(picture)
    update_publishes(picture.imageable_id) if picture.product?
  end

  private

  def update_publishes(product_id)
    Publish.by_product(product_id).update_all(updated_at: DateTime.now)
  end
end
