require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:image) { create(:image, :with_store) }

  it { should belong_to :store }
  it { should belong_to :business }

  it { should validate_presence_of :file }

  context '#belongs_to_corporate?' do
    it 'be false' do
      image = create(:image)
      expect(image.belongs_to_corporate?).to be_falsey
    end

    it 'be true' do
      expect(image.belongs_to_corporate?).to be_truthy
    end
  end
end
