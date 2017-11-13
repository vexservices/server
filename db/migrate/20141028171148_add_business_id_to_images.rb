class AddBusinessIdToImages < ActiveRecord::Migration
  def change
    add_reference :images, :business, index: true
  end
end