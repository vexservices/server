class AddDeviseFieldsToSellers < ActiveRecord::Migration
  def change
    ## Database authenticatable
    add_column :sellers, :encrypted_password, :string, null: false, default: ""

    ## Recoverable
    add_column :sellers, :reset_password_token,   :string
    add_column :sellers, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :sellers, :remember_created_at, :datetime

    ## Trackable
    add_column :sellers,:sign_in_count,       :integer, default: 0, null: false
    add_column :sellers, :current_sign_in_at, :datetime
    add_column :sellers, :last_sign_in_at,    :datetime
    add_column :sellers, :current_sign_in_ip, :inet
    add_column :sellers, :last_sign_in_ip,    :inet

    ## Index
    add_index :sellers, :email,                unique: true
    add_index :sellers, :reset_password_token, unique: true
  end
end
