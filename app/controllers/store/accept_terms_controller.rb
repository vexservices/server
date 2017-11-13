class Store::AcceptTermsController < Store::StoreController
  before_action :set_term

  def show
  end

  def update
    current_store.update_attribute(:term_version, @term.version)
    redirect_to categories_path, notice: t('messages.accepted_terms')
  end

  private

    def set_term
      @term = Term.first
    end
end