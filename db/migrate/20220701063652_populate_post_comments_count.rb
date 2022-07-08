# frozen_string_literal: true

# This migration is used to populate the `comments_count` column in the `posts` table.
class PopulatePostCommentsCount < ActiveRecord::Migration[7.0]
  def change
    Post.all.each do |post|
      Post.reset_counters(post.id, :comments)
    end
  end
end
