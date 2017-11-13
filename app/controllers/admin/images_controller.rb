class Admin::ImagesController < Admin::AdminController
  respond_to :html, :js

  before_action :set_corporate, only: [:edit, :update, :download]
  before_action :set_image, only: [:edit, :update]

  def edit
    admin_authorize policy.edit?
  end

  def update
    admin_authorize policy.update?

    if @image.update_attributes(image_params)
      flash[:notice] = t('flash_messages.updated', model: Image.model_name.human)
    end

    respond_with @image, location: edit_admin_corporate_image_url(@corporate)
  end

  def create
    admin_authorize policy.create?

    @business = Business.find(params[:business_id])
    @image = @business.images.create(image_params)
  end

  def destroy
    admin_authorize policy.destroy?

    @image = Image.find(params[:id])
    @image.destroy
  end

  def download
    admin_authorize policy.show?

    app = @corporate.app
    image = @corporate.logo_or_default

    unless image
      redirect_to admin_corporate_url(@corporate), alert: t('flash_messages.download_error')
    else
      redirect_to image.file.url
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

    def set_image
      @image = @corporate.image
    end


    def image_params
      params.require(:image).permit(:file)
    end
end
