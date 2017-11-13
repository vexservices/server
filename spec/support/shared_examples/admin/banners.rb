RSpec.shared_examples "manage banners" do
  it 'create' do
    visit admin_banners_path(locale: :en)

    click_on 'New Banner', match: :first

    attach_file(:banner_image, File.join(Rails.root, '/spec/files/app.png'))
    select 'English', from: :banner_locale
    click_on 'Create Banner'

    expect(page).to have_content('Banner was successfully created!')
    expect(current_path).to eq admin_banners_path(locale: :en)
  end

  it 'edit' do
    visit admin_banners_path(locale: :en)

    click_on 'edit', match: :first

    attach_file(:banner_image, File.join(Rails.root, '/spec/files/app.png'))
    select 'English', from: :banner_locale
    click_on 'Update Banner'

    expect(page).to have_content('Banner was successfully updated!')
    expect(current_path).to eq admin_banners_path(locale: :en)
  end
end
