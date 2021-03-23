class AddCustomerRefToLeads < ActiveRecord::Migration[5.2]
  def change
    add_reference :leads, :customer, foreign_key: true
  end
end
