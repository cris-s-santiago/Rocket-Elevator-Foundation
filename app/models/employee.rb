class Employee < ApplicationRecord
  belongs_to :user
  has_many :batteries, dependent: :destroy
end
