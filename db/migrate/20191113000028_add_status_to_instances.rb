class AddStatusToInstances < ActiveRecord::Migration[5.2]
  def change
    add_column :instances, :status, :boolean
    add_column :instances, :ip, :integer
    add_index :instances, :ip, :unique => true
  end
end
