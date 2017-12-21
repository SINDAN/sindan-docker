require 'rails_helper'

RSpec.describe "log_campaigns/edit", type: :view do
  before(:each) do
    @log_campaign = assign(:log_campaign, LogCampaign.create!(
      :log_campaign_uuid => "MyString",
      :ssid => "Ssid",
      :mac_addr => "MyString",
      :os => "MyString",
      :occurred_at => "2015-07-24 19:24:42",
    ))
  end

  it "renders the edit log_campaign form" do
    render

    assert_select "form[action=?][method=?]", log_campaign_path(@log_campaign), "post" do

      assert_select "input#log_campaign_log_campaign_uuid[name=?]", "log_campaign[log_campaign_uuid]"

      assert_select "input#log_campaign_ssid[name=?]", "log_campaign[ssid]"

      assert_select "input#log_campaign_mac_addr[name=?]", "log_campaign[mac_addr]"

      assert_select "input#log_campaign_os[name=?]", "log_campaign[os]"

      assert_select "select#log_campaign_occurred_at_1i[name=?]", "log_campaign[occurred_at(1i)]"
    end
  end
end
