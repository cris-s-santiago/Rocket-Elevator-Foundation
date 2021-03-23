class AddInterventionReference < ActiveRecord::Migration[5.2]
  def change
    add_reference :interventions, :customer, foreign_key: true
    add_reference :interventions, :building, foreign_key: true
    add_reference :interventions, :battery, foreign_key: true
    add_reference :interventions, :column, foreign_key: true
    add_reference :interventions, :elevator, foreign_key: true
    add_reference :interventions, :employee, foreign_key: true
    add_reference :interventions, :author, foreign_key: {to_table: :employees}
  end
end
