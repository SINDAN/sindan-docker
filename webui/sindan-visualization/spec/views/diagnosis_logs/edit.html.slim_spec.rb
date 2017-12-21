require 'rails_helper'

RSpec.describe "diagnosis_logs/edit", type: :view do
  before(:each) do
    @diagnosis_log = assign(:diagnosis_log, DiagnosisLog.create!(
      :layer => "web",
      :log_group => "Log Group",
      :log_type => "Log Type",
      :result => :fail,
      :detail => "Detail",
      :occurred_at => "2015-07-24 19:24:42",
    ))
  end

  it "renders the edit diagnosis_log form" do
    render

    assert_select "form[action=?][method=?]", diagnosis_log_path(@diagnosis_log), "post" do

      assert_select "select#diagnosis_log_layer[name=?]", "diagnosis_log[layer]"

      assert_select "input#diagnosis_log_log_group[name=?]", "diagnosis_log[log_group]"

      assert_select "input#diagnosis_log_log_type[name=?]", "diagnosis_log[log_type]"

      assert_select "select#diagnosis_log_result[name=?]", "diagnosis_log[result]"

      assert_select "textarea#diagnosis_log_detail[name=?]", "diagnosis_log[detail]"

      assert_select "select#diagnosis_log_occurred_at_1i[name=?]", "diagnosis_log[occurred_at(1i)]"
    end
  end
end
