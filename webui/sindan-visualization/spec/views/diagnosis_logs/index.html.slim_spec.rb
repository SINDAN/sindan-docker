require 'rails_helper'

RSpec.describe "diagnosis_logs/index", type: :view do
  before(:each) do
    assign(:diagnosis_logs, Kaminari.paginate_array([
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
    ]).page(1))
  end

  it "renders a list of diagnosis_logs" do
    render
    assert_select "tr>td", :text => "Layer".to_s, :count => 2
    assert_select "tr>td", :text => "Log Group".to_s, :count => 2
    assert_select "tr>td", :text => "Log Type".to_s, :count => 2
  end

  it "renders a class of diagnosis_log result" do
    render
    assert_select "tr.success", :count => 1
    assert_select "tr.danger", :count => 1
  end
end
