class AppObserver < ActiveRecord::Observer

  def before_save(app)
    if app.invalid_name_changed? && app.invalid_name?
      AppMailer.delay.invalid_app(app)
    end
  end

  def after_save(app)
    return if app.skip_observer

    if app.name_changed? && app.invalid_name?
      app.invalid_name  = false
      app.skip_observer = true
      app.save
    end
  end
end
