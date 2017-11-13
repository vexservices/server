require 'zip'

class Admin::AppsController < Admin::AdminController
  before_action :set_corporate, except: [:index]
  before_action :set_app, except: [:index]

  def index
    admin_authorize policy.show?

    if params[:seller_id]
      @seller = Seller.find(params[:seller_id])
      @stores = @seller.stores.corporates.joins(:app).order('created_at DESC').page(params[:page])
    end
  end

  def edit
    admin_authorize policy.edit?
  end

  def update
    admin_authorize policy.update?

    flash[:notice] = t('flash_messages.updated', model: App.model_name.human) if @app.update_attributes(app_params)
    respond_with @app, location: admin_corporate_url(@corporate)
  end

  def download
    admin_authorize policy.show?

    unless @app.app_cover
      redirect_to admin_corporate_url(@corporate), alert: t('flash_messages.download_error')
    else
      file = AppCoverZipService.new(@app)
      file.compress

      send_data(file.zip_data, :type => 'application/zip', :filename => "#{ @app.name.parameterize }_cover.zip")
    end
  rescue => e
    redirect_to admin_corporate_url(@corporate), alert: e.message
  end

  private

    def policy
      Admins::CorporatePolicy.new(current_admin, @corporate)
    end

    def set_corporate
      @corporate = Store.find(params[:corporate_id])
    end

    def set_app
      @app = @corporate.app
    end

    def app_params
      params.require(:app).permit(
        :name, :apple_certificate, :apple_store_url, :google_play_url, :google_api_key,
        :invalid_name, :test_mode
      )
    end
end
