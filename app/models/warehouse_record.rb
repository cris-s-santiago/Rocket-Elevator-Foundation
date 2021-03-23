class WarehouseRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :"warehouse_#{Rails.env}"
end
