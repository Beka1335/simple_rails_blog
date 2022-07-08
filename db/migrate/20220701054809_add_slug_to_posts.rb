# frozen_string_literal: true

# This migration is used to populate the `slug` column in the `posts` table.
class AddSlugToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true
  end
end
