class Store::Report::ProductsController < Store::StoreController
  set_tab :reports
  before_action :set_filters

  def index
    @publishes = current_store.publishes.by_date(@initial, @final).includes(product: [:category])
    @publishes = @publishes.page(params[:page])
  end

  private

    def set_filters
      if params[:search]
        if params[:search][:initial_date].present?
          @initial = Date.strptime(params[:search][:initial_date], I18n.t('date.formats.default'))
        end

        if params[:search][:final_date].present?
          @final   = Date.strptime(params[:search][:final_date], I18n.t('date.formats.default'))
        end
      end

      @initial ||= Date.current.beginning_of_month
      @final   ||= Date.current.end_of_month
    end
end
