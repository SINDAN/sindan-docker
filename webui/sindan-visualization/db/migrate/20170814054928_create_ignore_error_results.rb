class CreateIgnoreErrorResults < ActiveRecord::Migration[5.1]
  def change
    create_table :ignore_error_results do |t|
      t.string :ssid
      t.text :ignore_log_types

      t.timestamps
    end
  end
end
