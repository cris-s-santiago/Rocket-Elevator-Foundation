class Building < ApplicationRecord
    #belongs_to : customer
    #has_one :address
   has_many :building_details, dependent: :destroy
   belongs_to :customer
   belongs_to :address
   has_many :batteries, dependent: :destroy
   has_many :interventions, dependent: :destroy

   def loc_building
    "#{address.number_and_street} - #{address.city}"
end
    
end
