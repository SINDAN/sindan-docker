class AddLogUnitUuidToDiagnosisLog < ActiveRecord::Migration[5.0]
  def change
    add_column :diagnosis_logs, :log_unit_uuid, :string, limit: 38
    add_index :diagnosis_logs, :log_unit_uuid
  end
end
