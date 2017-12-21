class AddTargetToDiagnosisLog < ActiveRecord::Migration[5.1]
  def change
    add_column :diagnosis_logs, :target, :string
  end
end
