FactoryGirl.define do
  factory :schedule do
    store

    initial DateTime.now - 7.days
    final   DateTime.now + 7.days
    run_at  Time.now
  end
end
