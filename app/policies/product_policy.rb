class ProductPolicy < ApplicationPolicy
  attr_reader :user, :store, :record

  def initialize(user, record)
    @user  = user
    @store = user.store
    @record = record
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.store_id == record.store_id || store.corporate?
  end

  def edit?
    update?
  end

  def destroy?
    (user.store_id == record.store_id || store.corporate?) && !record.published?
  end

  def publish?
    store.can_publish_product? && store.ready? && !record.published? && !store.setup_payment?
  end

  def unpublish?
    if store.corporate?
      record.published?
    else
      (record.show_all? || record.store_id = store.id) && record.published?
    end
  end

  def unfeature?
    !record.try(:publish_feature_level).to_i.zero?
  end

  def publish_all?
    store.has_children? && !record.show_all? && record.store_id == store.id
  end

  def unpublish_all?
    store.has_children? && record.show_all? && record.store_id == store.id
  end

  class Scope
    attr_reader :user, :store, :scope

    def initialize(user, scope)
      @user  = user
      @store = user.store
      @scope = scope
    end

    def resolve
      Time.use_zone('UTC') do
        Product.select('products.*, pu.id as publish_id, pu.feature_level as publish_feature_level')
          .joins('LEFT JOIN products_stores ps on ps.product_id = products.id')
          .joins(
            %Q(LEFT JOIN publishes pu on pu.id = (
              SELECT id FROM publishes pub
              WHERE pub.product_id = products.id
              AND   pub.store_id = #{ store.id }
              AND   pub.removed_at ISNULL
              AND   published_until >= '#{ DateTime.current }'
              ORDER BY pub.id DESC
              LIMIT 1
            ))
          )
          .where('ps.store_id = :id OR (products.show_all = :bool AND products.store_id in (:store_id)) OR products.store_id = :id',
            id: store.id, bool: true, store_id: store.ancestor_ids)
          .distinct('products.id')
      end
    end
  end
end
