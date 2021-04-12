class InterventionsController < ApplicationController

    def interventionGetData
        id = request.query_parameters["id"]
        field = request.query_parameters["field"]

        @data = ""

        if field == 'building'
          @data = Building.where(customer: id)
        elsif field == 'battery'
          @data = Battery.where(building: id)
        elsif field == 'column'
          @data = Column.where(battery: id)
        elsif field == 'elevator'
          @data = Elevator.where(column: id)
        elsif
          @data = ""
        end
        
        puts "***********"
        puts @data
        puts "***********"

        return render json: @data
    end

    def create 
        @intervention = Intervention.new()

        @intervention.author = Employee.find_by(user_id: current_user.id).id
        @intervention.author_type = "Employee"
        @intervention.customer_id = params[:customer]
        @intervention.building_id = params[:building]
        @intervention.battery_id = params[:battery]
        @intervention.column_id = params[:column]
        @intervention.elevator_id = params[:elevator]
        @intervention.employee_id = params[:employee]        
        @intervention.report = params[:report]
        
        # Condition for null ids not required
        if @intervention.elevator_id
            @intervention.battery_id = nil
            @intervention.column_id = nil
        elsif @intervention.column_id
            @intervention.battery_id = nil
        end

        @intervention.save
        
        if @intervention.save!
            # Redirect back
            redirect_back fallback_location: interventions_path, notice: "Your Request was successfully created!"
        end
        #createZendesk()
    end

    def intervention_params
        params.permit( :customer, :building, :battery, :column, :elevator, :employee, :result, :report, :status)
    end
    
    def createZendesk
      client = ZendeskAPI::Client.new do |config|
        config.url = ENV['ZENDESK_URL']
        config.username = ENV['ZENDESK_USERNAME']
        config.token = ENV['ZENDESK_TOKEN']
      end
      
      ZendeskAPI::Ticket.create!(client, 
          :subject => "Support Request for client #{Customer.find(params[:customer]).company_name}",
          :comment => { 
              :value => "Hello #{Employee.find(params[:employee]).full_name}, you have a new intervention.\n\n
                        Please take note of the following service request.\n\n
                        - Customer: #{Customer.find(params[:customer]).company_name}
                        - Building ID: #{params[:building]}
                        - Battery ID: #{params[:battery]}
                        - Column ID: #{params[:column]}
                        - Elevator ID: #{params[:elevator]}
                        - Employee: #{Employee.find(params[:employee]).full_name}
                        - Description: #{params[:report]}"
                        
          }, 
          :requester => { 
              "name": Employee.find_by(user_id: current_user.id).full_name, 
          },
          :priority => "normal",
          :type => "problem"
          )
    end

end
