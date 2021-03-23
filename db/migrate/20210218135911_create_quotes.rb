class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|

      t.string  :company_name
      t.string  :contact_name
      t.string  :email 
      t.string  :product_line

      t.string :installation_fee
      t.string :sub_total
      t.string :total

      t.string  :building_type
      t.integer :num_of_floors
      t.integer :num_of_apartments
      t.integer :num_of_basements
      t.integer :num_of_parking_spots
      t.integer :num_of_distinct_businesses
      t.integer :num_of_elevator_cages
      t.integer :num_of_occupants_per_Floor
      t.integer :num_of_activity_hours_per_day
      t.integer :required_columns
      t.integer :required_shafts
      t.timestamps
    end
  end
end 