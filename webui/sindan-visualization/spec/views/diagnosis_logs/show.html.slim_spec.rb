require 'rails_helper'

RSpec.describe "diagnosis_logs/show", type: :view do
  before(:each) do
    @diagnosis_log = assign(:diagnosis_log, DiagnosisLog.create!(
      :layer => "Layer",
      :log_group => "Log Group",
      :log_type => "Log Type",
      :result => :fail,
      :detail => "Detail",
      :occurred_at => "2015-07-24 19:24:42",
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Layer/)
    expect(rendered).to match(/Log Group/)
    expect(rendered).to match(/Log Type/)
    expect(rendered).to match(/Detail/)
  end
end
