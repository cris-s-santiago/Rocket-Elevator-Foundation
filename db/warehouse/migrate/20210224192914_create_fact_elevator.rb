class CreateFactElevator < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_elevators do |t|
      t.string :serial_number
      t.datetime :commission_date
      t.integer :building_id
      t.integer :customer_id
      t.string :building_city
    end
  end
end
