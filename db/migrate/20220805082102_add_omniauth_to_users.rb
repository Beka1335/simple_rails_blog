class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string, default: '', null: false
    add_column :users, :uid, :string, default: '', null: false
  end
end
