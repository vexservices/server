class Api::StoresController < Api::ApiController
  acts_as_token_authentication_handler_for User

  def show
    @store = current_corporate.subtree.find(params[:id])
  end
end
