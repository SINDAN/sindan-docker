class ChangeColumnToDiagnosisLogsResult < ActiveRecord::Migration[5.0]
  def change
    remove_index :diagnosis_logs, :result
    change_column :diagnosis_logs, :result, :integer
    add_index :diagnosis_logs, :result
  end
end
