class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.string :building_type
      t.integer :number_of_floors_served
      t.string :status
      t.string :information
      t.text :notes


      t.timestamps
    end
  end
end
