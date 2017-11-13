RSpec.shared_examples "manage apps" do
  it 'edit' do
    visit admin_corporate_path(store, locale: :en)

    within('.actions') do
      click_on 'Edit App Settings', match: :first
    end

    fill_in :app_name, with: 'App Name 9990999'

    click_on 'Update App'

    expect(page).to have_content('App was successfully updated!')
    expect(current_path).to eq admin_corporate_path(store, locale: :en)
  end
end
