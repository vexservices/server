# Be sure to restart your server when you modify this file.

if Rails.env.development? || Rails.env.test?
  Rails.application.config.session_store :cookie_store, key: '_vex_apps_session', domain: :all
else
  Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 1.day
end
