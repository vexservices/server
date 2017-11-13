RSpec.shared_examples "manage corporates" do
  it 'edit' do
    visit admin_corporate_path(store, locale: :en)

    within('.actions') do
      click_on 'Edit', match: :first
    end

    fill_in :store_name, with: Faker::Company.name
    fill_in :store_cell_phone, with: Faker::PhoneNumber.phone_number
    fill_in :store_address_attributes_street, with: Faker::Address.street_address

    click_on 'Update Store'

    expect(page).to have_content('Store was successfully updated!')
    expect(current_path).to eq admin_corporate_path(store, locale: :en)
  end
end
