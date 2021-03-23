class CreateBatteries < ActiveRecord::Migration[5.2]
  def change
    create_table :batteries do |t|
      #buildingID
      t.string :building_type
      t.string :status
      #EmployeeID
      t.date :date_of_commissioning
      t.date :date_of_last_inspection
      t.string :certificate_of_operations
      t.string :information
      t.text :notes
      



      t.timestamps
    end
  end
end
