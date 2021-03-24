class InterventionsController < ApplicationController

    def interventionGetData
        id = request.query_parameters["id"]
        value = request.query_parameters["value"]
    
        @data = ""
        case value
        when "building"
          @data = Building.where(customer: id)
        when "battery"
          @data = Battery.where(building: id)
        when "column"
          @data = Column.where(battery: id)
        when "elevator"
          @data = Elevator.where(column: id)
        else
          @data = ""
        end
        
        return render json: @data
    end

    def create 
        @intervention = Intervention.new(intervention_params)
        
        puts '******************************'
        puts params     
        puts '******************************'

        @intervention.author_id = Employee.find(current_user.id).id
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
    end

    def intervention_params
        params.permit( :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :result, :report, :status)
    end
end
