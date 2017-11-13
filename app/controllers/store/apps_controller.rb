class Store::AppsController < Store::StoreController
  before_action :set_app

  def edit
  end

  def update
    bool = @app.setup_cover?

    if @app.update_attributes(app_params)
      flash[:notice] = if bool
        t('flash_messages.registration_finish_html', model: App.model_name.human)
      else
        t('flash_messages.updated', model: App.model_name.human)
      end
    end

    respond_with @app, location: categories_url
  end

  private

    def set_app
      @app = current_store.app
    end

    def app_params
      params.require(:app).permit(:use_logo, :app_cover, :require_authentication)
    end
end
