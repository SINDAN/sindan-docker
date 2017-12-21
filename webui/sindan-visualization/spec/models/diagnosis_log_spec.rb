# coding: utf-8
require 'rails_helper'

RSpec.describe DiagnosisLog, type: :model do
  before(:each) do
    @diagnosis_log = DiagnosisLog.new()
  end

  it "is valid with valid attributes" do
    expect(@diagnosis_log).to be_valid
  end

  it "is not valid with invalid value of result" do
    pending "invalid value occored other exception"

    @diagnosis_log.result = :invalid

    expect(@diagnosis_log).not_to be_valid
  end

  context "scope log" do
    before(:each) do
      FactoryBot.create(:diagnosis_log, result: 'success')
      FactoryBot.create(:diagnosis_log, result: 'fail')
      FactoryBot.create(:diagnosis_log, result: 'information')

      @diagnosis_logs = DiagnosisLog.log
    end

    it "not include error" do
      expect(@diagnosis_logs.count).to eq 2
    end
  end

  context "scope error" do
    before(:each) do
      FactoryBot.create(:diagnosis_log, result: 'success')
      FactoryBot.create(:diagnosis_log, result: 'fail')
      FactoryBot.create(:diagnosis_log, result: 'information')

      @diagnosis_logs = DiagnosisLog.fail
    end

    it "only include error " do
      expect(@diagnosis_logs.count).to eq 1
    end
  end

  context "Layer label" do
    before(:each) do
      @diagnosis_log = DiagnosisLog.new(
        layer: :web
      )
    end

    it "replace label with value of layer" do
      @diagnosis_log.layer = :web

      expect(@diagnosis_log.layer_label).to eq("ウェブアプリケーション層")
    end

    it "is not plane value with value of layer" do
      @diagnosis_log.layer = :web

      expect(@diagnosis_log.layer_label).not_to eq("web")
    end

    it "not replace label with invalid value of layer" do
      @diagnosis_log.layer = :invalid

      expect(@diagnosis_log.layer_label).to eq("invalid")
    end
  end

  context "Layer label for args" do
    it "replace label with value of layer" do
      layer_label = DiagnosisLog.layer_label('web')

      expect(layer_label).to eq("ウェブアプリケーション層")
    end

    it "is not plane value with value of layer" do
      layer_label = DiagnosisLog.layer_label('web')

      expect(layer_label).not_to eq("web")
    end

    it "not replace label with invalid value of layer" do
      layer_label = DiagnosisLog.layer_label('invalid')

      expect(layer_label).to eq("invalid")
    end
  end

  context "result_label" do
    context "without settings of ignore_log_types" do
      context "result is fail" do
        before(:each) do
          @diagnosis_log = DiagnosisLog.new(
            result: :fail
          )
        end

        it "result_label return 'fail'" do
          expect(@diagnosis_log.result_label).to eq("fail")
        end
      end

      context "result is not fail" do
        before(:each) do
          @diagnosis_log = DiagnosisLog.new(
            result: :success
          )
        end

        it "result_label return result of 'success'" do
          expect(@diagnosis_log.result_label).to eq("success")
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

      context "result is fail with ignore_log_types" do
        before(:each) do
          @diagnosis_log = FactoryBot.build(:diagnosis_log, log_campaign: @log_campaign, result: :fail, log_type: 'v4http_srv')
        end

        it "result_label return 'warning'" do
          expect(@diagnosis_log.result_label).to eq("warning")
        end
      end

      context "result is fail without ignore_log_types" do
        before(:each) do
          @diagnosis_log = FactoryBot.build(:diagnosis_log, log_campaign: @log_campaign, result: :fail, log_type: 'other')
        end

        it "result_label return 'warning'" do
          expect(@diagnosis_log.result_label).to eq("fail")
        end
      end

     context "result is not fail" do
        before(:each) do
          @diagnosis_log = FactoryBot.build(:diagnosis_log, log_campaign: @log_campaign, result: :success)
        end

        it "result_label return result of 'success'" do
          expect(@diagnosis_log.result_label).to eq("success")
        end
      end
    end
  end
end
