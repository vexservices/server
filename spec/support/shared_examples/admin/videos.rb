RSpec.shared_examples "manage videos" do
  it 'create' do
    visit admin_videos_path(locale: :en)
    click_on 'New Video', match: :first

    fill_in :video_html, with: '<p>My Video</p>'
    select 'English', from: :video_locale

    click_on 'Create Video'

    expect(page).to have_content('Video was successfully created!')
    expect(current_path).to eq admin_videos_path(locale: :en)
  end

  it 'edit' do
    visit admin_videos_path(locale: :en)
    click_on 'edit', match: :first

    fill_in :video_external_link, with: '//my_video_url.com'

    click_on 'Update Video'

    expect(page).to have_content('Video was successfully updated!')
    expect(current_path).to eq admin_videos_path(locale: :en)
  end
end
