class CreateDiagnosisLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnosis_logs do |t|
      t.string :layer
      t.string :log_type
      t.boolean :result
      t.text :detail
      t.datetime :occurred_at

      t.timestamps null: false
    end
    add_index :diagnosis_logs, :result
  end
end
