class Employee < ApplicationRecord
  belongs_to :user
  has_many :batteries, dependent: :destroy
  has_many :interventions, dependent: :destroy

  def full_name
    "#{last_name} #{first_name} "
  end
end
