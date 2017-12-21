require 'rails_helper'

RSpec.describe "ignore_error_results/new", type: :view do
  before(:each) do
    assign(:ignore_error_result, IgnoreErrorResult.new(
      ssid: "SSID",
    ))
  end

  it "renders new ignore_error_result form" do
    render

    assert_select "form[action=?][method=?]", ignore_error_results_path, "post" do
      assert_select "input#ignore_error_result_ssid[name=?]", "ignore_error_result[ssid]"
      assert_select "input#ignore_error_result_ignore_log_types_v6http_srv[name=?]", "ignore_error_result[ignore_log_types][]"
    end
  end
end
