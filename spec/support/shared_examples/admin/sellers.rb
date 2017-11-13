RSpec.shared_examples "manage sellers" do
  it 'create' do
    visit admin_sellers_path(locale: :en)
    click_on 'New Distributor', match: :first

    fill_in :seller_name, with: Faker::Name.name
    fill_in :seller_email, with: Faker::Internet.email
    fill_in :seller_password, with: 'secretpass'
    fill_in :seller_password_confirmation, with: 'secretpass'
    fill_in :seller_phone, with: Faker::PhoneNumber.phone_number
    fill_in :seller_cell_phone, with: Faker::PhoneNumber.cell_phone
    fill_in :seller_commission, with: '30'
    fill_in :seller_document, with: 'ABC-123'

    select 'United States', from: :seller_address_attributes_country
    fill_in :seller_address_attributes_state, with: Faker::Address.state
    fill_in :seller_address_attributes_city, with: Faker::Address.city
    fill_in :seller_address_attributes_street, with: Faker::Address.street_address
    fill_in :seller_address_attributes_zip, with: Faker::Address.zip

    click_on 'Create Distributor'

    expect(page).to have_content('Distributor was successfully created!')
    expect(current_path).to eq admin_sellers_path(locale: :en)
  end

  it 'edit' do
    visit admin_sellers_path(locale: :en)
    click_on 'edit', match: :first

    fill_in :seller_name, with: Faker::Name.name
    fill_in :seller_email, with: Faker::Internet.email
    fill_in :seller_password, with: 'secretpass'
    fill_in :seller_password_confirmation, with: 'secretpass'
    fill_in :seller_phone, with: Faker::PhoneNumber.phone_number
    fill_in :seller_cell_phone, with: Faker::PhoneNumber.cell_phone
    fill_in :seller_document, with: 'ABC-123'

    select 'United States', from: :seller_address_attributes_country
    fill_in :seller_address_attributes_state, with: Faker::Address.state
    fill_in :seller_address_attributes_city, with: Faker::Address.city
    fill_in :seller_address_attributes_street, with: Faker::Address.street_address
    fill_in :seller_address_attributes_zip, with: Faker::Address.zip

    click_on 'Update Distributor'

    expect(page).to have_content('Distributor was successfully updated!')
    expect(current_path).to eq admin_sellers_path(locale: :en)
  end
end
