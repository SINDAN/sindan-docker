require 'rails_helper'

RSpec.describe "DiagnosisLogs", type: :request do
  before(:each) do
    @diagnosis_log = FactoryBot.create(:diagnosis_log)
  end

  context "for authenticated users" do
    request_login_user

    describe "GET /diagnosis_logs" do
      it "works!" do
        get diagnosis_logs_path
        expect(response).to have_http_status(200)
      end

      it "works! with date params" do
        get diagnosis_logs_path(date: '20150731')
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /diagnosis_logs/:id" do
      it "works!" do
        get diagnosis_log_path(@diagnosis_log)
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /diagnosis_logs/new" do
      it "works!" do
        get new_diagnosis_log_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /diagnosis_logs/:id/edit" do
      it "works!" do
        get edit_diagnosis_log_path(@diagnosis_log)
        expect(response).to have_http_status(200)
      end
    end
  end

  context "for no authenticated users" do
    describe "GET /diagnosis_logs" do
      it "redirects to login page" do
        get diagnosis_logs_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it "redirects to login page with date params" do
        get diagnosis_logs_path(date: '20150731')
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /diagnosis_logs/:id" do
      it "redirects to login page" do
        get diagnosis_log_path(@diagnosis_log)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /diagnosis_logs/new" do
      it "redirects to login page" do
        get new_diagnosis_log_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /diagnosis_logs/:id/edit" do
      it "redirects to login page" do
        get edit_diagnosis_log_path(@diagnosis_log)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
