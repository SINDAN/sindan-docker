class RenameLogUnitUuidColumnToDiagnosisLogs < ActiveRecord::Migration[5.0]
  def change
    rename_column :diagnosis_logs, :log_unit_uuid, :log_campaign_uuid
  end
end
