# frozen_string_literal: true

class AddPremiumToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :premium, :boolean, default: false, null: false
  end
end
