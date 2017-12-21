require 'rails_helper'

RSpec.describe "ignore_error_results/index", type: :view do
  before(:each) do
    assign(:ignore_error_results, [
      IgnoreErrorResult.create!(
        ssid: "SSID1",
      ),
      IgnoreErrorResult.create!(
        ssid: "SSID2",
      ),
    ])
  end

  it "renders a list of ignore_error_results" do
    render

    assert_select "tr>td", :text => "SSID1".to_s, :count => 1
    assert_select "tr>td", :text => "SSID2".to_s, :count => 1
  end
end
