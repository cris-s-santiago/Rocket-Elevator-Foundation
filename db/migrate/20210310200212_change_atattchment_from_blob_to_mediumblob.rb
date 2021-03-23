class ChangeAtattchmentFromBlobToMediumblob < ActiveRecord::Migration[5.2]
  def change
    change_column :leads, :attachment, :binary, :limit => 10.megabyte
  end
end
