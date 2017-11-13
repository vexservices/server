RSpec.shared_examples "is deletable" do
  it "delete", :js do
    visit url

    click_on 'delete'
    confirm_dialog

    expect(page).to have_content("#{ klass } was successfully deleted!")
    expect(current_path).to eq url
  end
end
