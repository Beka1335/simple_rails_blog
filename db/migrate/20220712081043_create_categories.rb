# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, unique: true
      t.boolean :display_in_nav

      t.timestamps
    end
  end
end
