# frozen_string_literal: true

# This migration is used to populate the `name` column in the `users` table.
class AddNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
  end
end
