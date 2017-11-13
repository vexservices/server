RSpec.shared_examples "manage plans" do
  it 'create' do
    visit admin_plans_path(locale: :en)
    click_on 'New Plan', match: :first

    fill_in :plan_name, with: Faker::Name.name
    fill_in :plan_monthly_posts, with: 100
    fill_in :plan_price, with: 39.99
    check 'Popular'
    check 'E-mail Support'

    click_on 'Create Plan'
    expect(page).to have_content('Plan was successfully created!')
    expect(current_path).to eq admin_plans_path(locale: :en)
  end

  it 'edit' do
    visit admin_plans_path(locale: :en)
    click_on 'edit', match: :first

    fill_in :plan_name, with: Faker::Name.name
    fill_in :plan_monthly_posts, with: 150
    fill_in :plan_price, with: 59.99

    click_on 'Update Plan'
    expect(page).to have_content('Plan was successfully updated!')
    expect(current_path).to eq admin_plans_path(locale: :en)
  end
end
