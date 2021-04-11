class Interventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.integer :author
      t.string :author_type
      t.references :customer, foreign_key: true
      t.references :building, foreign_key: true
      t.references :battery, foreign_key: true, :null => true
      t.references :column, foreign_key: true, :null => true
      t.references :elevator, foreign_key: true, :null => true
      t.references :employee, foreign_key: true, :null => true      
      #the method :default permit to put a default value when the intervention is create
      t.datetime :start_date_intervention, :default => nil
      t.datetime :end_date_intervention, :default => nil
      t.string :result, :default => "Incomplete"
      t.text :report, null: false 
      t.string :status, :default => "Pending"

      t.timestamps
    end
    #rename_column :interventions, :author_id, :author
  end
end
