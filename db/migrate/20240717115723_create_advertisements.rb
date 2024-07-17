class CreateAdvertisements < ActiveRecord::Migration[7.1]
  def change
    create_table :advertisements do |t|
      t.string :brand
      t.string :model
      t.string :body_type
      t.integer :mileage
      t.string :colour
      t.integer :price
      t.string :fuel
      t.integer :year
      t.float :engine_capacity
      t.string :phone_number
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
