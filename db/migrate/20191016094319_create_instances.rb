class CreateInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :instances do |t|
      t.string :public_uid, null: false

      t.timestamps
    end
    add_index :instances, :public_uid, unique: true
  end
end
