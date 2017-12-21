class AddIndexToLogCampaign < ActiveRecord::Migration[5.0]
  def change
    add_index :log_campaigns, :occurred_at
  end
end
