# frozen_string_literal: true

# This migration is used to populate the `comments_count` column in the `posts` table.
class AddCommentCounterCacheToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comments_count, :integer
  end
end
