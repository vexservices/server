class Admin::CorporatesController < Admin::AdminController
  respond_to :html, :json

  set_tab :corporates

  before_action :set_corporate, except: [:index]

  def index
    scope = Admins::CorporatePolicy::Scope.new(current_admin, Store).resolve

    @q = scope.ransack(params[:q])

    @corporates = @q.result
                    .order('created_at DESC')

    if current_franchise.present?
      @corporates = @corporates.where(franchise_id: current_franchise.id)
    end

    respond_to do |format|
      format.html do
        @corporates = @corporates.includes(:franchise, :address, :seller, :app)
                                 .page(params[:page])
      end

      format.json do
        @corporates = @corporates.page(params[:page]).per(10)

        render json: {
          corporates: @corporates.as_json(only: [:id, :name]),
          total_count: @corporates.total_pages,
          page: @corporates.current_page
        }
      end
    end
  end

  def show
    admin_authorize policy.show?
  end

  def edit
    admin_authorize policy.edit?
  end

  def update
    admin_authorize policy.update?

    flash[:notice] = t('flash_messages.updated', model: Store.model_name.human) if @corporate.update_attributes(corporate_params)
    respond_with @corporate, location: admin_corporate_url(@corporate)
  end

  def destroy
    admin_authorize policy.destroy?

    flash[:notice] = t('flash_messages.deleted', model: Store.model_name.human) if @corporate.destroy
    respond_with @corporate, location: admin_corporates_url
  end

  private

    def policy
      Admins::CorporatePolicy.new(current_admin, @corporate)
    end

    def set_corporate
      if current_franchise.present?
        @corporate = current_franchise.stores.find(params[:id])
      else
        @corporate = Store.find(params[:id])
      end
    end

    def corporate_params
      params.require(:store).permit(
        :name, :cell_phone, :app_name, :time_zone, :payment_option,
        :plan_id, :phone, :official_email, :website, :contact, :trial_at,
        :admin_update, :plan_id, :seller_id, :blocked, :free_payment,
        address_attributes: [
          :id, :country, :state, :city, :street, :zip, :latitude, :longitude
        ]
      )
    end
end
