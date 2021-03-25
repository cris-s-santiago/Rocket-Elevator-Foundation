class Building < ApplicationRecord
   has_many :building_details, dependent: :destroy
   belongs_to :customer
   belongs_to :address
   has_many :batteries, dependent: :destroy
   has_many :interventions, dependent: :destroy    
end
