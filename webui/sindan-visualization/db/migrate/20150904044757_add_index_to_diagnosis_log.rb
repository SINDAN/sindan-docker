class AddIndexToDiagnosisLog < ActiveRecord::Migration[5.0]
  def change
    add_index :diagnosis_logs, :occurred_at
  end
end
