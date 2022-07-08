# frozen_string_literal: true

# This migration is used to populate the `slug` column in the `posts` table.
class RemoveBodyFromPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :body, :text
  end
end
