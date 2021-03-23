class Building < ApplicationRecord
    #belongs_to : customer
    #has_one :address
   has_many :building_details, dependent: :destroy
   belongs_to :customer
   belongs_to :address
   has_many :batteries, dependent: :destroy
    
end
