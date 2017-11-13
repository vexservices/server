class Admin::TermsController < Admin::AdminController
  include AdminPolicies

  set_tab :terms
  before_action :set_term

  def edit
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Term.model_name.human) if @term.update_attributes(term_params)
    respond_with @term, location: edit_admin_term_url
  end

  private

    def term_params
      params.require(:term).permit(:version, :text)
    end

    def set_term
      @term = Term.first_or_create
    end
end
