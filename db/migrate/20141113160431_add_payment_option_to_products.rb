class AddPaymentOptionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :payment_option, :string
  end
end
