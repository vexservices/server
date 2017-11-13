# encoding: UTF-8
require 'rails_helper'

RSpec.describe 'Sign Up Corporate', type: :feature do
  let(:corporate)  { create(:store) }
  let(:user)       { create(:user, store: corporate) }
  let!(:department) { create(:department, :super) }
  let!(:business)   { create(:business) }
  let(:franchise)  { create(:franchise) }
  let(:seller)     { create(:seller) }
  let(:plan)       { create(:plan) }

  context 'Step 1' do
    before(:each) { plan }

    it 'sign up new corporate' do
      visit new_user_registration_path(locale: :en)

      fill_in :user_name, with: Faker::Name.name
      fill_in :user_email, with: Faker::Internet.email
      fill_in :user_password, with: '12345678'
      fill_in :user_password_confirmation, with: '12345678'

      select department.title, from: :user_department
      select business.name,    from: :user_business

      fill_in :user_corporate_name, with: Faker::Company.name
      fill_in :user_app_name, with: 'My App'

      find(:select, :user_country).first(:option, 'United States').select_option

      fill_in :user_state, with: Faker::Address.state
      fill_in :user_city, with: Faker::Address.city
      fill_in :user_street, with: Faker::Address.street_address
      fill_in :user_zip, with: Faker::Address.zip
      fill_in :user_cell_phone, with: Faker::PhoneNumber.cell_phone
      fill_in :user_phone, with: Faker::PhoneNumber.phone_number

      select '(GMT+00:00) UTC', from: :user_time_zone

      fill_in :user_keywords, with: 'keywords'
      fill_in :user_short_description, with: Faker::Lorem.characters(20)
      fill_in :user_about, with: Faker::Lorem.characters(100)

      click_on 'Register'

      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'sign up with seller' do
      visit seller_path(seller.number, locale: :en)

      click_on 'Register'

      expect(page).to have_field(:user_seller_name, with: seller.name_with_number)

      fill_in :user_name, with: Faker::Name.name
      fill_in :user_email, with: Faker::Internet.email
      fill_in :user_password, with: '12345678'
      fill_in :user_password_confirmation, with: '12345678'

      select department.title, from: :user_department
      select business.name,    from: :user_business

      fill_in :user_corporate_name, with: Faker::Company.name
      fill_in :user_app_name, with: 'My App'

      find(:select, :user_country).first(:option, 'United States').select_option

      fill_in :user_state, with: Faker::Address.state
      fill_in :user_city, with: Faker::Address.city
      fill_in :user_street, with: Faker::Address.street_address
      fill_in :user_zip, with: Faker::Address.zip
      fill_in :user_cell_phone, with: Faker::PhoneNumber.cell_phone
      fill_in :user_phone, with: Faker::PhoneNumber.phone_number

      select '(GMT+00:00) UTC', from: :user_time_zone

      fill_in :user_keywords, with: 'keywords'
      fill_in :user_short_description, with: Faker::Lorem.characters(20)
      fill_in :user_about, with: Faker::Lorem.characters(100)

      click_on 'Register'

      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end


  context 'Step 1' do
    it 'sign up with franchise' do
      create(:plan, franchise: franchise)

      allow_any_instance_of(ApplicationController).to receive(:current_franchise).and_return(franchise)

      visit new_user_registration_path(locale: :en)

      fill_in :user_name, with: Faker::Name.name
      fill_in :user_email, with: Faker::Internet.email
      fill_in :user_password, with: '12345678'
      fill_in :user_password_confirmation, with: '12345678'

      select department.title, from: :user_department
      select business.name,    from: :user_business

      fill_in :user_corporate_name, with: Faker::Company.name
      fill_in :user_app_name, with: 'My App'

      find(:select, :user_country).first(:option, 'United States').select_option

      fill_in :user_state, with: Faker::Address.state
      fill_in :user_city, with: Faker::Address.city
      fill_in :user_street, with: Faker::Address.street_address
      fill_in :user_zip, with: Faker::Address.zip
      fill_in :user_cell_phone, with: Faker::PhoneNumber.cell_phone
      fill_in :user_phone, with: Faker::PhoneNumber.phone_number

      select '(GMT+00:00) UTC', from: :user_time_zone

      fill_in :user_keywords, with: 'keywords'
      fill_in :user_short_description, with: Faker::Lorem.characters(20)
      fill_in :user_about, with: Faker::Lorem.characters(100)

      click_on 'Register'

      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  context 'Step 2' do
    before(:each) do
      login_as(user, scope: :user)
    end

    it 'Setup app image' do
      visit categories_path(locale: :en)

      expect(current_path).to eq new_image_path(locale: :en)

      attach_file(:image_file, File.join(Rails.root, '/spec/files/app.png'))
      click_on 'Click here to upload your logo file.'

      expect(page).to have_content('Logo was successfully updated!')
    end
  end

  context 'Step 3' do
    let(:app)       { create(:app, :pendent) }
    let(:corporate) { create(:store, image: create(:image), app: app) }

    before(:each) do
      login_as(user, scope: :user)
    end

    it 'Setup App Cover' do
      visit categories_path(locale: :en)

      expect(current_path).to eq edit_app_path(locale: :en)

      attach_file(:app_app_cover, File.join(Rails.root, '/spec/files/app.png'))
      click_on 'Click here to upload your logo file.'

      expect(page).to have_content('Congratulations! You have successfully registered.')
    end

    it 'Skip' do
      visit categories_path(locale: :en)

      expect(current_path).to eq edit_app_path(locale: :en)

      click_on 'Skip Step'

      expect(page).to have_content('Congratulations! You have successfully registered.')
    end
  end
end
