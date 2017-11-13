FactoryGirl.define do
  factory :plan do
    name             'Plan'
    monthly_posts    200
    stores_limit     50
    users_count      15
    popular          true
    visible          true
    email_support    true
    chat_support     false
    individual_price 5.99
    price            199.99
    price_real       499.99
  end
end
