require 'rails_helper'

RSpec.describe "log_campaigns/show", type: :view do
  before(:each) do
    @log_campaign = assign(:log_campaign, LogCampaign.create!(
      :log_campaign_uuid => "Log Campaign Uuid",
      :ssid => "SSID",
      :mac_addr => "Mac Addr",
      :os => "Os",
      :occurred_at => "2015-07-24 19:24:42",
    ))

    assign(:diagnosis_logs, [
      DiagnosisLog.create!(
        :layer => "Layer",
        :log_group => "Log Group",
        :log_type => "Log Type",
        :result => :success,
        :detail => "Detail",
        :occurred_at => "2015-07-24 19:24:42",
      ),
      DiagnosisLog.create!(
        :layer => "Layer",
        :log_group => "Log Group",
        :log_type => "Log Type",
        :result => :fail,
        :detail => "Detail",
        :occurred_at => "2015-07-24 19:24:42",
      )
    ])
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Log Campaign Uuid/)
    expect(rendered).to match(/SSID/)
    expect(rendered).to match(/Mac Addr/)
    expect(rendered).to match(/Os/)
  end
end
