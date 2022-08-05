# frozen_string_literal: true

class CreateMobiles < ActiveRecord::Migration[7.0]
  def change
    create_table :mobiles do |t|
      t.string :number, null: false
      t.string :country, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
