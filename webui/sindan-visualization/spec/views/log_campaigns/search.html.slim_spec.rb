require 'rails_helper'

RSpec.describe "log_campaigns/search", type: :view do
  before(:each) do
    assign(:log_campaigns, Kaminari.paginate_array([
      LogCampaign.create!(
        :log_campaign_uuid => "Log Campaign Uuid 1",
        :ssid => "SSID",
        :mac_addr => "Mac Addr",
        :os => "Os",
        :occurred_at => "2015-07-24 19:24:42",
      ),
      LogCampaign.create!(
        :log_campaign_uuid => "Log Campaign Uuid 2",
        :ssid => "SSID",
        :mac_addr => "Mac Addr",
        :os => "Os",
        :occurred_at => "2015-07-24 19:24:42",
      )
    ]).page(1))
  end

  it "renders a list of log_campaigns" do
    render
    assert_select "tr>td", :text => "SSID".to_s, :count => 2
    assert_select "tr>td", :text => "Log Campaign Uuid 1".to_s, :count => 1
    assert_select "tr>td", :text => "Log Campaign Uuid 2".to_s, :count => 1
    assert_select "tr>td", :text => "Mac Addr".to_s, :count => 2
    assert_select "tr>td", :text => "Os".to_s, :count => 2
  end
end
