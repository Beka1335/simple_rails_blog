class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
