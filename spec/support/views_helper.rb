module ViewsHelper
  def number_to_currency(number, options = {})
    ActionController::Base.helpers.number_to_currency(number, options)
  end
end
