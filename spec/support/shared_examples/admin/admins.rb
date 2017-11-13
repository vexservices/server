RSpec.shared_examples "manage admins" do
  it 'create' do
    visit admin_admins_path(locale: :en)
    click_on 'New Admininstrator', match: :first

    fill_in :admin_name, with: Faker::Name.name
    fill_in :admin_email, with: Faker::Internet.email
    fill_in :admin_password, with: '87654321'
    fill_in :admin_password_confirmation, with: '87654321'

    click_on 'Create Admininstrator'
    expect(page).to have_content('Admininstrator was successfully created!')
    expect(current_path).to eq admin_admins_path(locale: :en)
  end

  it 'edit' do
    visit admin_admins_path(locale: :en)
    click_on 'edit', match: :first

    fill_in :admin_password, with: '12345678'
    fill_in :admin_password_confirmation, with: '12345678'

    click_on 'Update Admininstrator'
    expect(page).to have_content('Admininstrator was successfully updated!')
    expect(current_path).to eq admin_admins_path(locale: :en)
  end

  it 'edit profile' do
    visit edit_admin_profile_path(locale: :en)

    fill_in :admin_name, with: Faker::Name.name
    fill_in :admin_password, with: '12345678'
    fill_in :admin_password_confirmation, with: '12345678'

    click_on 'Update Admininstrator'
    expect(page).to have_content('Admininstrator was successfully updated!')
    expect(current_path).to eq edit_admin_profile_path(locale: :en)
  end
end
