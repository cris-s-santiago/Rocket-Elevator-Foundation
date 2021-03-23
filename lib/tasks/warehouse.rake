namespace :warehouse do
    desc "Transfer data to warehouse"
    task :import => :environment do
        puts "Import started"

        WarehouseRecord.connection.execute("TRUNCATE fact_quotes")
        
        # FactQuote.delete_all
        Quote.all.each do |quote|
            FactQuote.create!(
                quote_id: quote.id,
                creation_date: quote.created_at,
                company_name: quote.company_name,
                email: quote.email,
                num_elevators: quote.required_shafts
            )
        end
        puts "Quotes Imported"
        
        WarehouseRecord.connection.execute("TRUNCATE fact_contacts")

        # FactContact.delete_all
        Lead.all.each do |lead|
            FactContact.create!(
                contact_id: lead.id,
                creation_date: lead.created_at,
                company_name: lead.company_name,
                email: lead.email,
                project_name: lead.project_name
            )
        end
        puts "Leads Imported"
        
        WarehouseRecord.connection.execute("TRUNCATE fact_elevators")

        # FactElevator.delete_all
        Elevator.all.each do |elevator|
            FactElevator.create!(
                serial_number: elevator.serial_number,
                commission_date: elevator.date_of_commissioning,
                building_id: elevator.column.battery.building_id,
                customer_id: elevator.column.battery.building.customer_id,
                building_city: elevator.column.battery.building.address.city
            )
        end
        puts "Elevators Imported"

        WarehouseRecord.connection.execute("TRUNCATE dim_customers")

        # DimCustomer.delete_all
        Customer.all.each do |customer|
            numElevators = 0
            
            customer.buildings.all.each do |building|
            # byebug #debugger
            building.batteries.all.each do |battery|
                battery.columns.all.each do |column|
                    numElevators += column.elevators.count
                    end #Column
                end #Battery
            end #Building
            
            DimCustomer.create!(
                creation_date: customer.customers_creation_date,
                company_name: customer.company_name,
                company_contact: customer.full_name_of_company_contact,
                company_email: customer.email_of_company_contact,
                nb_elevators: numElevators,
                customer_city: customer.address.city
            )
        end #Customer
        puts "Customers Imported"

        WarehouseRecord.connection.execute("TRUNCATE fact_interventions")

        #fact_intervention fake data 
        10.times do 
            result = ["Success", "Failure", "Incomplete"].sample
            status = ["Pending", "InProgress", "Interrupted", "Resumed", "Complete"].sample 
        
            FactIntervention.create!({
                employee_id: Faker::Number.within(range: 1..50), #=> 1968353479,
                building_id: Faker::Number.within(range: 1..50),
                battery_id: Faker::Number.within(range: 1..50),
                column_id: Faker::Number.within(range: 1..100),
                elevator_id: Faker::Number.within(range: 1..10),
                start_of_intervention: Faker::Time.backward(days: 5, period: :morning, format: :short),
                end_of_intervention: Faker::Time.forward(days: 5, period: :morning, format: :short),
                result: result,   #Success, Failure or Incomplete
                report: nil, 
                status: status    #Pending, InProgress, Interrupted, Resumed or Complete
            })
        end
        puts "Interventions Imported"


        puts "Import Ended"
    end #task
end #namespace