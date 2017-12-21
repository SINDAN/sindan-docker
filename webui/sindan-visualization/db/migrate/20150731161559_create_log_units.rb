class CreateLogUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :log_units do |t|
      t.string :log_unit_uuid, limit: 38
      t.string :mac_addr
      t.string :os
      t.datetime :occurred_at

      t.timestamps null: false
    end
    add_index :log_units, :log_unit_uuid
  end
end
