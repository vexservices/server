RSpec.shared_examples "manage paypals" do
  it 'create' do
    visit admin_paypals_path(locale: :en)
    click_on 'New PayPal', match: :first

    fill_in :paypal_user, with: 'paypal_user'
    fill_in :paypal_login, with: 'paypal_login'
    fill_in :paypal_password, with: 'password'
    select 'United States', from: 'Country'

    click_on 'Create PayPal'

    expect(page).to have_content('PayPal was successfully created!')
    expect(current_path).to eq admin_paypals_path(locale: :en)
  end

  it 'edit' do
    visit admin_paypals_path(locale: :en)
    click_on 'edit', match: :first

    fill_in :paypal_user, with: 'new_paypal_user'
    fill_in :paypal_login, with: 'new_paypal_login'
    fill_in :paypal_password, with: 'new_password'

    click_on 'Update PayPal'

    expect(page).to have_content('PayPal was successfully updated!')
    expect(current_path).to eq admin_paypals_path(locale: :en)
  end
end
