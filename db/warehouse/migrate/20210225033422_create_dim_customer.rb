class CreateDimCustomer < ActiveRecord::Migration[5.2]
  def change
    create_table :dim_customers do |t|
      t.datetime :creation_date
      t.string :company_name
      t.string :company_contact
      t.string :company_email
      t.integer :nb_elevators
      t.string :customer_city
    end
  end
end
