class ChangeObserver < ActiveRecord::Observer
  observe :store, :app, :image

  def after_update(model)
    if model.is_a? Store
      log_store(model)
    elsif model.is_a? App
      log_app(model)
    elsif model.is_a? Image
      log_image(model)
    end
  end

  private

    def log_store(store)
      return unless store.corporate?

      changes = []

      if store.department_id_changed?
        changes << "Department_id: #{ store.department_id_was } to #{ store.department_id } ( #{ store.department_name } )"
      end

      if store.keywords_changed?
        changes << "Keywords: #{ store.keywords_was } to #{ store.keywords }"
      end

      if store.about_changed?
        changes << "Description: #{ store.about }"
      end

      if store.short_description_changed?
        changes << "Short Description: #{ store.short_description }"
      end

      if store.app_logo_id_changed?
        changes << "Logo: #{ store.app_logo.file }"
      end

      if changes.present?
        store.logs.create(log: changes.join(" \n"))
      end
    end

    def log_app(app)
      changes = []

      if app.name_changed?
        changes << "App Name: #{ app.name_was } to #{ app.name }"
      end

      if app.app_cover_changed?
        changes << "App Cover: #{ app.app_cover }"
      end

      if changes.present?
        if store = app.store
          store.logs.create(log: changes.join(" \n"))
        end
      end
    end

    def log_image(image)
      changes = []

      if image.file_changed?
        changes << "Logo: #{ image.file }"
      end

      if changes.present?
        if store = image.store
          store.logs.create(log: changes.join(" \n"))
        end
      end
    end
end
