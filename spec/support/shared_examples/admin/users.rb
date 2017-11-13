RSpec.shared_examples "manage users" do
  it 'edit' do
    visit url

    within('#users') do
      click_on 'edit'
    end

    fill_in :user_password, with: '12345678'
    fill_in :user_password_confirmation, with: '12345678'

    click_on 'Update User'

    expect(page).to have_content('User was successfully updated!')
    expect(current_path).to eq url
  end
end
