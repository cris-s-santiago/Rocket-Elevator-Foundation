module RailsAdmin
    module Config
      module Actions
        class Map< RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
  
          register_instance_option :root do
            true
          end
  
          register_instance_option :http_methods do
            [:get]
          end          
  
          register_instance_option :link_icon do
            'icon-map-marker'
          end
          
          register_instance_option :controller do
            proc do              
              # Array that will be used for Google Marker
              @data = []

              # Loop to find the information in each Building           
              Building.find_each do |building|
                
                numElevators = 0
                numColumns = 0
                numBattery = building.batteries.count
                numFloor = 0
                
                # Loop to find the number of floors in the building 
                building.building_details.where(building_id:building.id).all.each do |details|
                  if  details.information_key == "Number of Floors"
                    numFloor = details.value
                  end
                end

                # Loop to find the number of columns and elevators
                building.batteries.all.each do |battery|
                  numColumns += battery.columns.count
                  battery.columns.all.each do |column|
                    numElevators += column.elevators.count
                  end #Column
                end #Battery
                
                # Capture of address information.
                address = building.address
                fullAddress = " #{address.number_and_street}, #{address.city}, #{address.postal_code}"
                @lat = address.latitude
                @lng = address.longitude                
        
                # Filling Array with the information captured
                if @lat != nil  &&  @lng != nil
                  @data << {id: building.id,
                          location: fullAddress,
                          floor: numFloor,
                          client: building.customer.company_name, 
                          lat: @lat, lng: @lng,  
                          battery: numBattery, column: numColumns, elevator: numElevators,
                          technician: building.full_name_of_the_technical_contact_for_the_building}
                end                          
              end
            end
          end  
        end
      end
    end
  end