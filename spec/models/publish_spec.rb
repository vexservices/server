require 'rails_helper'

RSpec.describe Publish, type: :model do
  it { should belong_to :product }
  it { should belong_to :store }
  it { should belong_to :user }

  it '#product_category_name' do
    should delegate_method(:product_category_name).to(:product).as(:category_name)
  end

  it '#product_image' do
    should delegate_method(:product_image).to(:product).as(:image)
  end
end
