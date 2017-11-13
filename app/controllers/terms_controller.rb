class TermsController < ApplicationController
  layout 'login'

  def index
    @term = Term.first
  end
end