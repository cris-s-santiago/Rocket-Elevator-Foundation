class QuotesController < ApplicationController
 
  # # GET /quotes or /quotes.json
  # def index
  #   @quotes = Quote.all
  # end

  # # GET /quotes/1 or /quotes/1.json
  # def show
  # end

  # # GET /quotes/new
  # def new
  #   @quote = Quote.new
  # end

  
  # POST /quotes or /quotes.json
  def create
    #===================================================================================================
    # PRINTS PARAMS INTO TERMINAL WINDOW
    #===================================================================================================
   
    puts "===========START================"
    puts params
    puts "=============END================"

    #===================================================================================================
    # SETUP VARIABLES BELOW
    #===================================================================================================
   
    # Building Type
    building_type = params["buildType"]
    
    # Residential
    residential_floors = params["floors_residential"]
    residential_apartments = params["apartments-residential"]
    residential_basements = params["basements-residential"]

    # Commercial
    commerical_commerce = params["commerce-commercial"]
    commerical_floors = params["floors-commercial"]
    commerical_basements = params["basements-commercial"]
    commerical_parking = params["parking-commercial"]
    commerical_elevators = params["elevators-commercial"]

    # Corporate
    corporate_commerce = params["commerce-corporate"]
    corporate_floors = params["floors-corporate"]
    corporate_basements = params["basements-corporate"]
    corporate_parking = params["parking-corporate"]
    corporate_occupants = params["occupants-corporate"]
    corporate_activity = params["activity-corporate"]

    # Hybrid
    hybrid_businesses = params["businesses-hybrid"]
    hybrid_floors = params["floors-hybrid"]
    hybrid_basements = params["basements-hybrid"]
    hybrid_parking = params["parking-hybrid"]
    hybrid_occupants = params["occupants-hybrid"]
    hybrid_activity = params["activity-hybrid"]

    # Product Line - Value will either be 1, 2, or 3
    product_line = params["radio-btn"]

    # Recommendations
    number_of_columns = params["recommended-columns"]
    number_of_elevator_shafts = params["recommended-elevators"]

    # Cost
    cost = params["cost"]
    installation = params["installation"]
    total = params["total"]

   
    # Company Name
    company_name = params["company_name"]
    # Contact Of Company name
    contact_name = params["contact_name"]
    # Email Address
    email = params["email"]
    
   #===================================================================================================
   # SETUP OF LOGIC 
   #===================================================================================================
  
   @quote = Quote.new(quote_params)

    @quote.company_name = company_name
    @quote.contact_name = contact_name
    @quote.email = email

    @quote.building_type =  building_type

    @quote.required_columns = number_of_columns
    @quote.required_shafts = number_of_elevator_shafts

    @quote.installation_fee = installation
    @quote.sub_total = cost
    @quote.total = total


    if building_type == "residential" 
      @quote.num_of_floors = residential_floors
      @quote.num_of_apartments = residential_apartments
      @quote.num_of_basements = residential_basements
    end

    if building_type == "commercial" 
      @quote.num_of_distinct_businesses = commerical_commerce
      @quote.num_of_floors = commerical_floors
      @quote.num_of_basements = commerical_basements
      @quote.num_of_parking_spots = commerical_parking
      @quote.num_of_elevator_cages = commerical_elevators
    end

    if building_type == "corporate"
      @quote.num_of_distinct_businesses = corporate_commerce
      @quote.num_of_floors = corporate_floors
      @quote.num_of_basements = corporate_basements
      @quote.num_of_parking_spots = corporate_parking
      @quote.num_of_occupants_per_Floor = corporate_occupants
      @quote.num_of_activity_hours_per_day = corporate_activity
    end

    if building_type == "hybrid"
      @quote.num_of_distinct_businesses = hybrid_businesses
      @quote.num_of_floors = hybrid_floors
      @quote.num_of_basements = hybrid_basements
      @quote.num_of_parking_spots = hybrid_parking
      @quote.num_of_occupants_per_Floor = hybrid_occupants
      @quote.num_of_activity_hours_per_day = hybrid_activity
    end
    
    if product_line == "1"
      @quote.product_line = "Standard"
    elsif product_line == "2"
      @quote.product_line = "Premium"
    else
      @quote.product_line = "Excelium"
    end
    
    @quote.save!


   #===================================================================================================
   # AFTER FORM SUBMISSION LOGIC (submission alert, redirecting, rendering, errors) 
   #===================================================================================================

    if @quote.save
      redirect_back fallback_location: root_path, notice: "Your Quote was successfully created and sent!"
    end

    # client = ZendeskAPI::Client.new do |config|
    #   config.url = ENV['ZENDESK_URL']
    #   config.username = ENV['ZENDESK_USERNAME']
    #   config.token = ENV['ZENDESK_TOKEN']
    # end
  
    # ZendeskAPI::Ticket.create!(client, 
    #   :subject => "#{@quote.contact_name} from #{@quote.company_name}", 
    #   :comment => { 
    #       :value => "The contact: #{@quote.contact_name}, from company: #{@quote.company_name}, who can be reached at the email: #{@quote.email}, submitted a quote for a #{@quote.building_type} building.
    #           Based on the calculations, there are #{@quote.required_columns} columns required, with #{@quote.required_shafts} elevator shafts.
    #           This project is calculated to cost #{@quote.sub_total}, with #{@quote.installation_fee} in installation fees, for a total price of #{@quote.total}."
    #   }, 
    #   :requester => { 
    #       "name": @quote.contact_name, 
    #       # "email": @quote.email 
    #   },
    #   :priority => "normal",
    #   :type => "question"
    #   )

  end # End for def Create




   #===================================================================================================
   # DEFINING @quote = Quote.new(quote_params) BELOW:
   #===================================================================================================

   # Only allow a list of trusted parameters through.
  def quote_params
    params.fetch(:quote, {})
  end

end # End of class Quote
