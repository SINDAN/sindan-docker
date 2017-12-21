class AddSsidToLogCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :log_campaigns, :ssid, :string
    add_index :log_campaigns, :ssid

    # migrate ssid of diagnosis log -> log campaign
    LogCampaign.all.each do |log_campaign|
      ssid = log_campaign.diagnosis_logs.where(log_type: 'ssid').first
      unless ssid.nil?
        log_campaign.ssid = ssid.detail
        log_campaign.save
      end
    end
  end
end
