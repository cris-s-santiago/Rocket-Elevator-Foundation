class Battery < ApplicationRecord
    has_many :columns, dependent: :destroy #this assure that if a battery is deleted the column in it get deleted too
    belongs_to :building
    belongs_to :employee
end
