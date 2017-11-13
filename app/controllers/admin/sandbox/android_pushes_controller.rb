class Admin::Sandbox::AndroidPushesController < Admin::AdminController
  include AdminPolicies

  before_action :set_app, only: [:create]

  def new
  end

  def create
    flash.clear

    token = params[:push][:device]

    gcm = GCM.new(@app.google_api_key)

    options = { 'data' => { 'title' => 'Virtual Exchange', 'message' => 'Android Push Test'} }

    response = gcm.send_notification([token], options)
    response = JSON.parse(response[:body])

    if response['success'].to_i == 1
      flash[:notice] = "Push was successfully sended!"
    else
      errors = response['results'].map { |r| r['error'] }.join(', ')
      flash[:allert] = "Sorry! We're sorry, but something went wrong. Error: #{errors}"
    end

    render :new
  rescue Exception => e
    flash[:alert] = "Sorry! We're sorry, but something went wrong. Error: #{Rack::Utils.escape_html e}"
    render :new
  end

  private

    def set_app
      @app = App.find(params[:push][:app_id])
    end
end
