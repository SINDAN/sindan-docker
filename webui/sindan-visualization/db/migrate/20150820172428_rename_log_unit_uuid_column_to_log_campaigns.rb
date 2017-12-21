class RenameLogUnitUuidColumnToLogCampaigns < ActiveRecord::Migration[5.0]
  def change
    rename_column :log_campaigns, :log_unit_uuid, :log_campaign_uuid
  end
end
