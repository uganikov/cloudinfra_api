class AddColumnTypeToInstances < ActiveRecord::Migration[5.2]
  def change
    add_column :instances, :type, :string
  end
end
