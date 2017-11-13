class Admin::Sandbox::AppsController < Admin::AdminController
  include AdminPolicies

  before_action :set_app, except: [:index, :new, :create]

  def index
    @apps = App.without_store.page(params[:page])
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)

    flash[:notice] = t('flash_messages.updated', model: App.model_name.human) if @app.save
    respond_with @app, location: admin_sandbox_apps_url
  end

  def edit
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: App.model_name.human) if @app.update_attributes(app_params)
    respond_with @app, location: admin_sandbox_apps_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: App.model_name.human) if @app.destroy
    respond_with @app, location: admin_sandbox_apps_u
  end

  private
    def set_app
      @app = App.find(params[:id])
    end

    def app_params
      params.require(:app).permit(
        :name, :apple_certificate, :apple_store_url, :google_play_url, :google_api_key
      )
    end
end
