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
        Intervention.all.each do |intervention|
            FactIntervention.create(
                employee_id: intervention.employee_id, 
                building_id: intervention.building_id, 
                battery_id: intervention.battery_id, 
                column_id: intervention.column_id, 
                elevator_id: intervention.elevator_id, 
                start_of_intervention: intervention.start_date_intervention, 
                end_of_intervention: intervention.end_date_intervention, 
                result: intervention.result,
                report: intervention.report, 
                status: intervention.status
            )
        end
        puts "Interventions Imported"


        puts "Import Ended"
    end #task
end #namespace