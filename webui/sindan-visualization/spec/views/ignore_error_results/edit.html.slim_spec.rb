require 'rails_helper'

RSpec.describe "ignore_error_results/edit", type: :view do
  before(:each) do
    @ignore_error_result = assign(:ignore_error_result, IgnoreErrorResult.create!(
      ssid: "SSID",
    ))
  end

  it "renders the edit ignore_error_result form" do
    render

    assert_select "form[action=?][method=?]", ignore_error_result_path(@ignore_error_result), "post" do
      assert_select "input#ignore_error_result_ssid[name=?]", "ignore_error_result[ssid]"
      assert_select "input#ignore_error_result_ignore_log_types_v6http_srv[name=?]", "ignore_error_result[ignore_log_types][]"
    end
  end
end
