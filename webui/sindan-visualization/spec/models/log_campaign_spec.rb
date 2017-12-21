require 'rails_helper'

RSpec.describe LogCampaign, type: :model do
  before(:each) do
    @log_campaign = LogCampaign.new()
  end

  it "is valid with valid attributes" do
    expect(@log_campaign).to be_valid
  end

  it "is not valid with same value of log_campaign_uuid" do
    @log_campaign.log_campaign_uuid = "8D9CEC4B-9A99-4A44-BFDA-445C6765475A"
    @log_campaign.save

    @log_campaign2 = FactoryBot.build(:log_campaign)
    @log_campaign2.log_campaign_uuid = "8D9CEC4B-9A99-4A44-BFDA-445C6765475A"

    expect(@log_campaign2).not_to be_valid
  end

  context "result" do
    context "without settings of ignore_log_types" do
      before(:each) do
        @log_campaign = FactoryBot.create(:log_campaign, ssid: 'SSID')
      end

      context "diagnosis_log result is fail" do
        before(:each) do
          @diagnosis_log = FactoryBot.create(:diagnosis_log, log_campaign: @log_campaign, result: :fail)
        end

        it "return 'fail'" do
          expect(@log_campaign.result).to eq("fail")
        end
      end

      context "diagnosis_log result is not fail" do
        before(:each) do
          @diagnosis_log = FactoryBot.create(:diagnosis_log, log_campaign: @log_campaign, result: :success)
        end

        it "return 'success'" do
          expect(@log_campaign.result).to eq("success")
        end
      end

      context "diagnosis_log is empty" do
        it "return 'information'" do
          expect(@log_campaign.result).to eq("information")
        end
      end
    end

    context "with settings of ignore_log_types" do
      before(:each) do
        @ignore_error_result = FactoryBot.create(:ignore_error_result,
                                                  ssid: 'SSID',
                                                  ignore_log_types: ["v4http_srv", "v6trans_aaaa_namesrv"],
                                                 )
        @log_campaign = FactoryBot.create(:log_campaign, ssid: 'SSID')
      end

      context "diagnosis_log result is fail with ignore_log_types" do
        before(:each) do
          @diagnosis_log = FactoryBot.create(:diagnosis_log, log_campaign: @log_campaign, result: :fail, log_type: 'v4http_srv')
        end

        it "return 'warning'" do
          expect(@log_campaign.result).to eq("warning")
        end
      end

      context "diagnosis_log result is fail without ignore_log_types" do
        before(:each) do
          @diagnosis_log = FactoryBot.create(:diagnosis_log, log_campaign: @log_campaign, result: :fail, log_type: 'other')
        end

        it "return 'fail'" do
          expect(@log_campaign.result).to eq("fail")
        end
      end

      context "diagnosis_log result is not fail" do
        before(:each) do
          @diagnosis_log = FactoryBot.create(:diagnosis_log, log_campaign: @log_campaign, result: :success)
        end

        it "return 'success'" do
          expect(@log_campaign.result).to eq("success")
        end
      end

      context "diagnosis_log is empty" do
        it "return 'information'" do
          expect(@log_campaign.result).to eq("information")
        end
      end
    end
  end
end
