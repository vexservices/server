# TODO: Refactore to use a class instead helpers
module CacheHelper
  # Cache for home page
  def cache_key_for_home_page(franchise = nil)
    if franchise
      max_updated_at = franchise.updated_at.try(:utc).try(:to_s, :number)

      "home_page-#{ franchise.id }-#{max_updated_at}-#{I18n.locale}"
    else
      'home_page'
    end
  end

  # Cache for select of departments in sign_up form
  def cache_key_for_super_departments
    count          = Department.super.count
    max_updated_at = Department.super.maximum(:updated_at).try(:utc).try(:to_s, :number)

    "departments/select-#{count}-#{max_updated_at}-#{I18n.locale}"
  end

  def cache_key_for_department(department)
    updated_at = department.try(:updated_at).try(:utc).try(:to_s, :number)

    "department/#{current_store.try(:id)}#{department.try(:id)}-#{updated_at}"
  end

  # Cache for select of subdepartments in sign_up form
  def cache_key_for_subdepartments
    count          = Department.sub.count
    max_updated_at = Department.sub.maximum(:updated_at).try(:utc).try(:to_s, :number)

    "subdepartments/select-#{count}-#{max_updated_at}-#{I18n.locale}"
  end

  ## Cache for Store namespace
  def cache_key_for_store_categories
    categories = policy_scope(Category)

    count          = categories.count
    max_updated_at = categories.maximum(:updated_at).try(:utc).try(:to_s, :number)
    id             = current_store.try(:id)

    "categoreis/all-#{id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_category(category)
    updated_at = category.try(:updated_at).try(:utc).try(:to_s, :number)

    "category/#{current_store.try(:id)}-#{category.try(:id)}-#{updated_at}"
  end

  def cache_key_for_store_departments
    sections = policy_scope(Department)

    count          = sections.count
    max_updated_at = sections.maximum(:updated_at).try(:utc).try(:to_s, :number)
    id             = current_store.try(:id)

    "departments/all-#{id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_store_schedules
    count          = current_store.schedules.count
    max_updated_at = current_store.schedules.maximum(:updated_at).try(:utc).try(:to_s, :number)
    id             = current_store.try(:id)

    "schedules/all-#{id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_store_stores
    count          = current_store.stores.count
    max_updated_at = current_store.stores.maximum(:updated_at).try(:utc).try(:to_s, :number)
    id             = current_store.try(:id)
    business_id    = current_corporate.try(:business_id)

    "stores/all-#{id}-#{business_id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_store_users
    count          = current_store.users.count
    max_updated_at = current_store.users.maximum(:updated_at).try(:utc).try(:to_s, :number)
    id             = current_store.try(:id)

    "users/all-#{id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_store_clients
    count          = current_store.clients.count
    max_updated_at = current_store.clients.maximum(:updated_at).try(:utc).try(:to_s, :number)
    id             = current_store.try(:id)

    "clients/all-#{id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_store_invoices
    count          = current_store.invoices.count
    max_updated_at = current_store.invoices.maximum(:updated_at).try(:utc).try(:to_s, :number)
    id             = current_store.try(:id)

    "invoices/all-#{id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_product_search
    categories = policy_scope(Category)

    count          = categories.count
    max_updated_at = categories.maximum(:updated_at).try(:utc).try(:to_s, :number)
    id             = current_store.try(:id)

    "products/search-#{id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_products
    products = policy_scope(Product)

    count          = products.count('products.id')
    max_updated_at = products.maximum(:updated_at).try(:utc).try(:to_s, :number)
    store_id       = current_store.try(:id)

    "products/all-#{store_id}-#{count}-#{max_updated_at}"
  end

  def cache_key_for_product(product)
    updated_at = product.try(:updated_at).try(:utc).try(:to_s, :number)
    publish_id = product.try(:publish_id) || 0
    store_id   = current_store.try(:id)
    id         = product.try(:id)

    "product/#{id}-#{store_id}-#{publish_id}-#{updated_at}"
  end

  def cache_for_stores_three(stores)
    max_updated_at = stores.maximum(:updated_at).try(:utc).try(:to_s, :number)
    count          = stores.count
    id             = current_store.try(:id)

    "stores/tree-#{id}-#{count}-#{max_updated_at}"
  end
end
