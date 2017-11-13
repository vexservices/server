class RedirectsController < ApplicationController

  def index
    if params[:id]
      corporate = Store.find_by_number(params[:id]).first
      path      = new_corporate_branch_store_path(corporate) if corporate.present?
    end

    path ||= root_path

    redirect_to path
  end
end
