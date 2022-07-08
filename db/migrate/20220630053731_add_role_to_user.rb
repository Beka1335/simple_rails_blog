# frozen_string_literal: true

# This migration is used to populate the `role` column in the `users` table.
class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer
  end
end
