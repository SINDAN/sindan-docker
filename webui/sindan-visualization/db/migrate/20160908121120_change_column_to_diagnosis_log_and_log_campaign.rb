class ChangeColumnToDiagnosisLogAndLogCampaign < ActiveRecord::Migration[5.0]
  def change
    change_column :log_campaigns, :created_at, :datetime, null: true
    change_column :log_campaigns, :updated_at, :datetime, null: true
    change_column :diagnosis_logs, :created_at, :datetime, null: true
    change_column :diagnosis_logs, :updated_at, :datetime, null: true
  end
end
