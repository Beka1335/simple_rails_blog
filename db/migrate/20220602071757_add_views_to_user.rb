# frozen_string_literal: true

# This migration is used to populate the `AddViewsToUser` column in the `users` table.
class AddViewsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :views, :integer
  end
end
