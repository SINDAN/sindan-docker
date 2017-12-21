class RenameLogUnitsToLogCampaigns < ActiveRecord::Migration[5.0]
  def change
    rename_table :log_units, :log_campaigns
  end
end
