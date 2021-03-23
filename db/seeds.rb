# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employee_list = [
  {
    first_name: "Nicolas",
    last_name: "Genest",
    title: "CEO",
    email: "nicolas.genest@codeboxx.biz"
  },
  {
    first_name: "Nadya",
    last_name: "Fortier",
    title: "Director",
    email: "nadya.fortier@codeboxx.biz"
  },
  {
    first_name: "Martin",
    last_name: "Chantal",
    title: "Director Assistant",
    email: "martin.chantal@codeboxx.biz"
  },
  {
    first_name: "Mathieu",
    last_name: "Houde",
    title: "Captain",
    email: "mathieu.houde@codeboxx.biz"
  },
  {
    first_name: "David",
    last_name: "Boutin",
    title: "Engineer",
    email: "david.boutin@codeboxx.biz"
  },
  {
    first_name: "Mathieu",
    last_name: "Lortie",
    title: "Engineer",
    email: "mathieu.lortie@codeboxx.biz"
  },
  {
    first_name: "Thomas",
    last_name: "Carrier",
    title: "Engineer",
    email: "thomas.carrier@codeboxx.biz"
  },
]

puts "Seed Started"
######################################################

#-----------------------------------------------### Seed Employee ###-------------------------------------------------
puts "Seed Employee"
employee_list.each do |employee|
  user = User.create!(
    email: employee[:email],
    password: "codeboxx1",
    employee_role: true,
    user_role: false
  )
  employee = Employee.create!(
    first_name: employee[:first_name],
    last_name: employee[:last_name],
    title: employee[:title],
    email: employee[:email],
    user: user
  )
end

### Seeding Users for presentation ###
User.create!(email: 'admin@admin.com', password: 'password', superadmin_role: 1, employee_role: 0, user_role: 0)
User.create!(email: 'employee@employee.com', password: 'password', superadmin_role: 0, employee_role: 1, user_role: 0)
User.create!(email: 'user@user.com', password: 'password', superadmin_role: 0, employee_role: 0, user_role: 1)


#-----------------------------------------------### Seed Address ###-------------------------------------------------
puts "Seed Addresses"

#Auxiliary Address variables
type_of_address = ["Billing", "Shipping", "Home", "Business"]
status_type = ["Active", "Inactive"]
entity_type = ["Building", "Customer"]


CSV.foreach(Rails.root.join('db', 'Address.csv'), headers: true) do |row|
    Address.create!(
      type_of_address: type_of_address.sample, 
      status: status_type.sample, 
      entity: entity_type.sample, 
      number_and_street: row['number_and_street'], 
      suite_and_apartment: nil, 
      city: row['city'],
      postal_code: row['postal_code'], 
      country: row['country'], 
      notes: nil)
end


# Select addresses according to the entity
addressListBuilding = []
addressListCustomer = []

Address.all.each do |address|

  if address.entity == "Building"
    addressListBuilding << (address.id)
  end
  if address.entity == "Customer"
    addressListCustomer << (address.id)
  end

end


#-----------------------------------------------### Seed Quote ###-------------------------------------------------
puts "Seed Quote"

#---------------------------### Residential ###---------------------------
75.times do 

  num_of_floors = Faker::Number.between(from: 2, to: 60)
  num_of_apartments = Faker::Number.between(from: 5, to: 150)
  product_line = ['Standard', 'Premium', 'Excelium'].sample

  numShaftsRes = ((num_of_apartments / num_of_floors.to_f) / 6).ceil
  numColumnsRes = (num_of_floors / 20.to_f).ceil
  numTotalShaftsRes = (numShaftsRes * numColumnsRes)
  
  if product_line == 'Standard'
    value = 7565
    fee = 0.10
  elsif product_line == 'Premium'
    value = 12345
    fee = 0.13
  elsif product_line == 'Excelium'
    value = 15400
    fee = 0.16   
  end
  
  costTotalShafts = (value * numTotalShaftsRes)
  costInstallation = (fee * costTotalShafts).round(2)
  costTotal = (costTotalShafts + costInstallation)

  Quote.create!({
    company_name: Faker::Company.unique.name,
    contact_name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    product_line: product_line,
    installation_fee: costInstallation,
    sub_total: costTotalShafts,
    total: costTotal,
    building_type: "Residential",
    num_of_floors: num_of_floors,
    num_of_apartments: num_of_apartments,
    num_of_basements: Faker::Number.between(from: 1, to: 6),
    num_of_parking_spots: 0,
    num_of_distinct_businesses: 0,
    num_of_elevator_cages: 0,
    num_of_occupants_per_Floor: 0,
    num_of_activity_hours_per_day: 0,
    required_columns: numColumnsRes,
    required_shafts: numTotalShaftsRes,
    created_at: Faker::Date.between(from: '2018-02-23', to: '2021-02-23')
  })
end
#---------------------------### Commercial ###---------------------------
75.times do

  num_of_floors = Faker::Number.between(from: 2, to: 60)
  num_of_elevator_cages = Faker::Number.between(from: 1, to: 20)
  product_line = ['Standard', 'Premium', 'Excelium'].sample

  numColumns = (num_of_floors / 20.to_f).ceil
  
  if product_line == 'Standard'
    value = 7565
    fee = 0.10
  elsif product_line == 'Premium'
    value = 12345
    fee = 0.13
  elsif product_line == 'Excelium'
    value = 15400
    fee = 0.16   
  end
  
  costTotalShafts = (value * num_of_elevator_cages)
  costInstallation = (fee * costTotalShafts).round(2)
  costTotal = (costTotalShafts + costInstallation)

  Quote.create!({
    company_name: Faker::Company.unique.name,
    contact_name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    product_line: product_line,
    installation_fee: costInstallation,
    sub_total: costTotalShafts,
    total: costTotal,
    building_type: "Commercial",
    num_of_floors: num_of_floors,
    num_of_apartments: 0,
    num_of_basements: Faker::Number.between(from: 3, to: 6),
    num_of_parking_spots: Faker::Number.between(from: 10, to: 250),
    num_of_distinct_businesses: Faker::Number.between(from: 1, to: 10),
    num_of_elevator_cages: num_of_elevator_cages,
    num_of_occupants_per_Floor: 0,
    num_of_activity_hours_per_day: 0,
    required_columns: numColumns,
    required_shafts: num_of_elevator_cages,
    created_at: Faker::Date.between(from: '2018-02-23', to: '2021-02-23')
  })
end
#---------------------------### Corporate/Hybrid ###---------------------------
150.times do

  num_of_floors = Faker::Number.between(from: 2, to: 60)
  num_of_basements = Faker::Number.between(from: 2, to: 6)
  num_of_occupants_per_Floor = Faker::Number.between(from: 10, to: 150)
  product_line = ['Standard', 'Premium', 'Excelium'].sample


  totalOccupantsCorHybr= (num_of_occupants_per_Floor * (num_of_floors + num_of_basements))
  numShaftsRequired= (totalOccupantsCorHybr / 1000.to_f).ceil
  numColumnsCorHybr= ((num_of_floors + num_of_basements) / 20.to_f).ceil
  numShaftsColumm= (numShaftsRequired / numColumnsCorHybr.to_f).ceil
  numTotalShaftsCorHybr= (numShaftsColumm * numColumnsCorHybr)

  
  if product_line == 'Standard'
    value = 7565
    fee = 0.10
  elsif product_line == 'Premium'
    value = 12345
    fee = 0.13
  elsif product_line == 'Excelium'
    value = 15400
    fee = 0.16   
  end
  
  costTotalShafts = (value * numTotalShaftsCorHybr)
  costInstallation = (fee * costTotalShafts).round(2)
  costTotal = (costTotalShafts + costInstallation)

  Quote.create!({
    company_name: Faker::Company.unique.name,
    contact_name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    product_line: product_line,
    installation_fee: costInstallation,
    sub_total: costTotalShafts,
    total: costTotal,
    building_type: [:Corporate, :Hybrid].sample,
    num_of_floors: num_of_floors,
    num_of_apartments: 0,
    num_of_basements: num_of_basements,
    num_of_parking_spots: Faker::Number.between(from: 10, to: 250),
    num_of_distinct_businesses: Faker::Number.between(from: 1, to: 10),
    num_of_elevator_cages: 0,
    num_of_occupants_per_Floor: num_of_occupants_per_Floor,
    num_of_activity_hours_per_day: Faker::Number.between(from: 8, to: 24),
    required_columns: numColumnsCorHybr,
    required_shafts: numTotalShaftsCorHybr,
    created_at: Faker::Date.between(from: '2018-02-23', to: '2021-02-23')
  })
end
#-----------------------------------------------### END Seed Quote ###-------------------------------------------------


puts "Seed User, Lead, Customer, Building, BuildingDetail, Battery, Column and Elevator"

#Auxiliary BuildingDetail variables
typeList = ["Residential", "Commercial", "Corporate", "Hybrid"]
typeArchitecture = ["Neoclassical", "Victorian", "Modern", "Neofuturist"]


50.times do 
#-----------------------------------------------### Seed User ###-------------------------------------------------
    current_user = User.create!({
      email: Faker::Internet.unique.email, 
      password: 'password'
    })
    
#-----------------------------------------------### Seed Customer ###-------------------------------------------------
    current_customer = Customer.create!({
      user_id: current_user.id,
      address_id: addressListCustomer.sample,
      customers_creation_date: Faker::Date.between(from: '1976-02-23', to: '2021-02-23'),
      company_name: Faker::Company.unique.name,
      full_name_of_company_contact: Faker::Name.unique.name,
      company_contact_phone: Faker::PhoneNumber.unique.cell_phone,
      email_of_company_contact: Faker::Internet.unique.email,
      company_description: Faker::Lorem.unique.paragraph,
      full_name_of_service_technical_authority: Faker::Name.unique.name,
      technical_authority_phone_for_service_: Faker::PhoneNumber.unique.cell_phone,
      technical_manager_email_for_service: Faker::Internet.unique.email
    })

#-----------------------------------------------### Seed Building ###-------------------------------------------------
    current_building = Building.create!({
      customer_id: current_customer.id,
      address_id: addressListBuilding.sample,
      full_name_of_the_building_administrator: Faker::Name.unique.name,
      email_of_the_administrator_of_the_building: Faker::Internet.unique.email,
      phone_number_of_the_building_administrator: Faker::PhoneNumber.unique.cell_phone,
      full_name_of_the_technical_contact_for_the_building: Faker::Name.unique.name,
      technical_contact_email_for_the_building: Faker::Internet.unique.email,
      technical_contact_phone_for_the_building: Faker::PhoneNumber.unique.cell_phone,
    })

#-----------------------------------------------### Seed BuildingDetail ###-------------------------------------------------
    BuildingDetail.create!(
        information_key: "Type",
        value: typeList.sample,
        building_id: current_building.id
    )
    BuildingDetail.create!(
        information_key: "Construction Year",
        value: Faker::Date.between(from: '1950-01-01', to: '2020-02-25'),
        building_id: current_building.id
    )
    BuildingDetail.create!(
        information_key: "Architecture",
        value: typeArchitecture.sample,
        building_id: current_building.id
    )
    BuildingDetail.create!(
        information_key: "Last Renovation Year",
        value: Faker::Date.between(from: '1991-09-23', to: '2010-09-25'),
        building_id: current_building.id
    )
    BuildingDetail.create!(
        information_key: "Number of Floors",
        value: Faker::Number.between(from: 5, to: 60),
        building_id: current_building.id
    )

#-----------------------------------------------### Seed Battery ###-------------------------------------------------
    current_battery = Battery.create!({
      building_id: current_building.id,
      building_type: [:Residential, :Commercial, :Corporate, :Hybrid].sample,
      status: [:Active, :intervation, :Inactive].sample,
      employee_id: Employee.order('rand()').limit(1).first.id,
      date_of_commissioning: Faker::Date.between(from: '2018-02-23', to: '2021-02-23'),
      date_of_last_inspection: Faker::Date.between(from: '2018-02-23', to: '2021-02-23'),
      certificate_of_operations: Faker::Alphanumeric.unique.alphanumeric(number: 10),
      information: Faker::Lorem.sentence(word_count: 3),
      notes: Faker::Lorem.unique.paragraph
    })

#-----------------------------------------------### Seed Column ###-------------------------------------------------
    numRand = rand(1..3)
    numRand.times do 
      current_column = Column.create!({
        battery_id: current_battery.id,
        building_type: current_battery.building_type,
        number_of_floors_served: Faker::Number.between(from: 2, to: 60),
        status: [:Active, :Intervention, :Inactive].sample,
        information: Faker::Lorem.sentence(word_count: 3),
        notes: Faker::Lorem.unique.paragraph
      })

#-----------------------------------------------### Seed Elevator ###-------------------------------------------------
        rand(1..3).times do
          Elevator.create!({
            column_id: current_column.id,
            serial_number: Faker::Alphanumeric.unique.alphanumeric(number: 15),
            model: [:Standard, :Premium, :Excelium].sample,
            building_type: current_battery.building_type,
            status: [:Active, :Inactive].sample,  # Removed Intervention status because of Twilio.
            date_of_commissioning: Faker::Date.between(from: '2018-02-23', to: '2021-02-23'),
            date_of_last_inspection: Faker::Date.between(from: '2018-02-23', to: '2021-02-23'),
            certificate_of_inspection: Faker::Alphanumeric.unique.alphanumeric(number: 15),
            information: Faker::Lorem.sentence(word_count: 3),
            notes: Faker::Lorem.unique.paragraph
          })
        end
    end    
end

#-----------------------------------------------### Seed Lead ###-------------------------------------------------

ext = ['zip', 'pdf', 'jpg', 'png', 'txt']

300.times do

  isCustomer = Faker::Boolean.boolean(true_ratio: 0.3)

  customers_id = nil

  if isCustomer
    customers_id = Faker::Number.between(from: 1, to: 50)
  end

  Lead.create!({
    full_name_of_contact: Faker::Name.name,
    company_name: Faker::Company.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.unique.cell_phone,
    project_name: Faker::Lorem.sentence(word_count: 2),
    project_description: Faker::Lorem.unique.sentence,
    department_in_charge_of_elevators: [:Sales, :Support, :Administration].sample,
    message: Faker::Lorem.unique.paragraph,
    file_name: Faker::File.file_name(dir: 'foo/bar', name: 'contact', ext: ext.sample),
    created_at: Faker::Date.between(from: '2018-02-23', to: '2021-02-23'),
    customer_id: customers_id
  })
end


#####################################################
puts "Seed Ended"