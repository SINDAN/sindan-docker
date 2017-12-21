require 'rails_helper'

RSpec.describe IgnoreErrorResult, type: :model do
  before(:each) do
    @ignore_error_result = IgnoreErrorResult.new(
      ssid: 'SSID',
    )
  end

  it "is valid with valid attributes" do
    expect(@ignore_error_result).to be_valid
  end

  it "is not valid without ssid" do
    @ignore_error_result.ssid = nil

    expect(@ignore_error_result).not_to be_valid
  end

  it "is not valid with same value of ssid" do
    @ignore_error_result.save
    @ignore_error_result2 = IgnoreErrorResult.new(ssid: 'SSID')

    expect(@ignore_error_result2).not_to be_valid
  end

  context "ignore_log_types by ssid" do
    context "ignore_log_types set values" do
      before(:each) do
        @ignore_error_result = IgnoreErrorResult.create(
          ssid: 'SSID',
          ignore_log_types: ["v4http_srv", "v6trans_aaaa_namesrv"],
        )
      end

      it "ignore_log_types return values" do
        ssid = "SSID"

        expect(IgnoreErrorResult.ignore_log_types_by_ssid(ssid).count).not_to be_zero
        expect(IgnoreErrorResult.ignore_log_types_by_ssid(ssid)).to eq @ignore_error_result.ignore_log_types
      end

      it "ignore_log_types is empty " do
        ssid = "invalid"

        expect(IgnoreErrorResult.ignore_log_types_by_ssid(ssid)).to be_nil
      end
    end

    context "ignore_log_types is empty" do
      before(:each) do
        @ignore_error_result = IgnoreErrorResult.create(
          ssid: 'SSID',
          ignore_log_types: [],
        )
      end

      it "ignore_log_types return values" do
        ssid = "SSID"

        expect(IgnoreErrorResult.ignore_log_types_by_ssid(ssid).count).to be_zero
      end

      it "ignore_log_types is empty " do
        ssid = "invalid"

        expect(IgnoreErrorResult.ignore_log_types_by_ssid(ssid)).to be_nil
      end
    end
  end
end
