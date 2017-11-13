require 'rails_helper'

RSpec.describe Importer, type: :model do
  let(:store) { create(:store) }
  let(:job)   { create(:job, store: store) }

  subject { described_class.new(job) }

  describe '#import' do
    context 'import product' do
      let(:expected_products) do
        [
          {
            code: '10',
            name: 'Product One',
            category: 'Category',
            regular_price: 100.0,
            price: 50.0
          },
          {
            code: '20',
            name: 'Product Two',
            category: 'Category',
            regular_price: 200.0,
            price: 150.0
          }
        ]
      end

      let(:products) { store.products.order(code: :asc) }

      it 'create a list of products' do
        expect(store.products.count).to eq(0)

        subject.import

        expect(store.products.count).to eq(2)

        products.each_with_index do |product, index|
          expected_product = expected_products[index]

          expect(product.code).to eq(expected_product[:code])
          expect(product.name).to eq(expected_product[:name])
          expect(product.category_name).to eq(expected_product[:category])
          expect(product.regular_price).to eq(expected_product[:regular_price])
          expect(product.price).to eq(expected_product[:price])
        end
      end
    end

    context 'import department' do
      let(:job) { create(:job, :department, store: store) }
      let(:departments) { store.sections.order(id: :asc) }

      it 'create a list of department' do
        expect(store.sections.count).to eq(0)

        subject.import

        expect(store.sections.count).to eq(2)

        departments_names = departments.map { |d| d.name }
        expect(departments_names).to eq(['Department One', 'Department Two'])
      end
    end

    context 'import stores' do
      let(:job) { create(:job, :branch_store, store: store) }
      let(:branch_store) { store.stores.first }
      let(:user) { branch_store.users.first }

      it 'create a list of department' do
        expect(store.stores.count).to eq(0)

        subject.import

        expect(store.stores.count).to eq(1)

        expect(branch_store.name).to eq('Store')
        expect(branch_store.cell_phone).to eq('5555-1234')
        expect(branch_store.time_zone).to eq('Central Time (US & Canada)')
        expect(branch_store.phone).to eq('5555-5555')
        expect(branch_store.contact).to eq('Contact')
        expect(branch_store.official_email).to eq('email@mail.com')
        expect(branch_store.website).to be_nil
        expect(branch_store.about).to eq('Store to import')
        expect(branch_store.address.country).to eq('Country')
        expect(branch_store.address.state).to eq('State')
        expect(branch_store.address.street).to eq('Street')
        expect(branch_store.address.city).to eq('City')
        expect(branch_store.address.zip).to eq('00000')

        expect(user.name).to eq('User Name')
        expect(user.email).to eq('user001@mail.com')
      end
    end
  end
end
