class Admin::Sandbox::IosPushesController < Admin::AdminController
  include AdminPolicies

  before_action :set_app, only: [:create]

  def new
  end

  def create
    flash.clear

    token = params[:push][:device]

    apn = Houston::Client.production

    notification = Houston::Notification.new(device: token.ios_token)
    notification.alert = "Send Push Test."

    if Rails.env.production? || Rails.env.staging?
      temp_file = Tempfile.new('certificate')

      File.open(temp_file.path, "wb") do |f|#
        f.write HTTParty.get(@app.apple_certificate.url).parsed_response
      end

      apn.certificate = File.read(temp_file.path)
    else
      apn.certificate = File.read(@app.apple_certificate.path)
    end

    apn.push(notification)

    flash[:notice] = "Push was successfully sended!"
    render :new
  rescue Exception => e
    flash[:alert] = "Sorry! We're sorry, but something went wrong. Error: #{e}"
    render :new
  end

  private

    def set_app
      @app = App.find(params[:push][:app_id])
    end
end
