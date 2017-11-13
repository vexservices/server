require "rails_helper"

RSpec.describe AppMailer, type: :mailer do
  let(:corporate) { create(:store, :ready) }
  let(:user)      { create(:user, store: corporate) }

  before(:each) do
    user
  end

  it 'App invalid email' do
    allow(I18n).to receive(:locale) { :en }

    email = AppMailer.invalid_app(corporate.app).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal corporate.emails, email.to
    assert_equal "Invalid app", email.subject
    assert_match /You App name is invalid/, email.encoded
  end
end
