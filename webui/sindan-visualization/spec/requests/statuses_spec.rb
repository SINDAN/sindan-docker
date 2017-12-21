require 'rails_helper'

RSpec.describe "Statuses", type: :request do
  context "for authenticated users" do
    request_login_user

    describe "GET /status/index" do
      it "works!" do
        get statuses_path
        expect(response).to have_http_status(200)
      end
    end
  end

  context "for no authenticated users" do
    describe "GET /status/index" do
      it "redirects to login page" do
        get statuses_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
