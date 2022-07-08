# frozen_string_literal: true

# This migration is used to populate the `AddUserToPosts` column in the `users` table.
class AddUserToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
