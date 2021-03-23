class Interventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      #the method :default permit to put a default value when the intervention is create
      t.datetime :start_date_intervention, :default => nil
      t.datetime :end_date_intervention, :default => nil
      t.string :result, :default => "Incomplete"
      t.text :report
      t.string :status, :default => "Pending"

      t.timestamps
    end
  end
end
