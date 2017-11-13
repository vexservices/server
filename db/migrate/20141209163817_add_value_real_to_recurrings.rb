class AddValueRealToRecurrings < ActiveRecord::Migration
  def change
    add_column :recurrings, :value_real, :decimal, precision: 8, scale: 2
  end
end
