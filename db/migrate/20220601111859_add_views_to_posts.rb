# frozen_string_literal: true

# This migration is used to populate the `AddViewsToPosts` column in the `users` table.
class AddViewsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :views, :integer, default: 0
  end
end
