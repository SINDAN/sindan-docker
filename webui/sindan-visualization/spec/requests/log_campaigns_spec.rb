require 'rails_helper'

RSpec.describe "LogCampaigns", type: :request do
  before(:each) do
    @log_campaign = FactoryBot.create(:log_campaign)
  end

  context "for authenticated users" do
    request_login_user

    describe "GET /log_campaigns" do
      it "works!" do
        get log_campaigns_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /log_campaigns/search" do
      it "works!" do
        get search_log_campaigns_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /log_campaigns/:id" do
      it "works!" do
        get log_campaign_path(@log_campaign)
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /log_campaigns/new" do
      it "works!" do
        get new_log_campaign_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /log_campaigns/:id/edit" do
      it "works!" do
        get edit_log_campaign_path(@log_campaign)
        expect(response).to have_http_status(200)
      end
    end
  end

  context "for no authenticated users" do
    describe "GET /log_campaigns" do
      it "redirects to login page" do
        get log_campaigns_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /log_campaigns/search" do
      it "redirects to login page" do
        get search_log_campaigns_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /log_campaigns/:id" do
      it "redirects to login page" do
        get log_campaign_path(@log_campaign)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /log_campaigns/new" do
      it "redirects to login page" do
        get new_log_campaign_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /log_campaigns/:id/edit" do
      it "redirects to login page" do
        get edit_log_campaign_path(@log_campaign)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
