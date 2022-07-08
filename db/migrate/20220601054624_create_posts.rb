# frozen_string_literal: true

# This migration is used to populate the `CreatePosts` column in the `users` table.
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
