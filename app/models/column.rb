class Column < ApplicationRecord
    belongs_to :battery
    has_many :elevators, dependent: :destroy
    has_many :interventions, dependent: :destroy   
end