if Rails.env.production? || Rails.env.staging?
  # Server timeout in seconds
  Rack::Timeout.timeout = 120
end
