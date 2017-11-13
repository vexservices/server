FactoryGirl.define do
  factory :paypal do
    login    'paypal-account'
    password '12345678'
    partner  'PayPal'
    sandbox  true
    country 'US'
  end
end
