# Setup sandbox in Pagseguro
# PagSeguro.environment = :sandbox

PagSeguro.configure do |config|
  config.email = Rails.application.secrets.pagseguro_email
  config.token = Rails.application.secrets.pagseguro_token
end
