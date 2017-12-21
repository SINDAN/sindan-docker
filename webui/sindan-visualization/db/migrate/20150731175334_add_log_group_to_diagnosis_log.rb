class AddLogGroupToDiagnosisLog < ActiveRecord::Migration[5.0]
  def change
    add_column :diagnosis_logs, :log_group, :string
  end
end
