require 'rails_helper'

RSpec.describe "ignore_error_results/show", type: :view do
  before(:each) do
    @ignore_error_result = assign(:ignore_error_result, IgnoreErrorResult.create!(
      ssid: "SSID",
    ))
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to match(/SSID/)
  end
end
