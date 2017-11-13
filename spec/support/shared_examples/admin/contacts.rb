RSpec.shared_examples "manage contacts" do
  it 'show' do
    visit admin_contacts_path(locale: :en)

    click_on 'show', match: :first

    expect(current_path).to eq admin_contact_path(contact, locale: :en)

    expect(page).to have_content(contact.name)
    expect(page).to have_content(contact.email)
    expect(page).to have_content(contact.message)
  end
end
