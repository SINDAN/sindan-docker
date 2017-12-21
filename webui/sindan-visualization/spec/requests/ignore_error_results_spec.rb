require 'rails_helper'

RSpec.describe "IgnoreErrorResults", type: :request do
  before(:each) do
    @ignore_error_result = FactoryBot.create(:ignore_error_result)
  end

  context "for authenticated users" do
    request_login_user

    describe "GET /ignore_error_results" do
      it "works!" do
        get ignore_error_results_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /ignore_error_resultss/:id" do
      it "works!" do
        get ignore_error_result_path(@ignore_error_result)
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /ignore_error_resultss/new" do
      it "works!" do
        get new_ignore_error_result_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /ignore_error_resultss/:id/edit" do
      it "works!" do
        get edit_ignore_error_result_path(@ignore_error_result)
        expect(response).to have_http_status(200)
      end
    end
  end

  context "for no authenticated users" do
    describe "GET /ignore_error_results" do
      it "redirects to login page" do
        get ignore_error_results_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /ignore_error_resultss/:id" do
      it "redirects to login page" do
        get ignore_error_result_path(@ignore_error_result)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /ignore_error_resultss/new" do
      it "redirects to login page" do
        get new_ignore_error_result_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /ignore_error_resultss/:id/edit" do
      it "redirects to login page" do
        get edit_ignore_error_result_path(@ignore_error_result)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
