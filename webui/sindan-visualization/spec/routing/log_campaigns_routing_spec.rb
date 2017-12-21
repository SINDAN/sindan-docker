require "rails_helper"

RSpec.describe LogCampaignsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/log_campaigns").to route_to("log_campaigns#index")
    end

    it "routes to #search" do
      expect(:get => "/log_campaigns/search").to route_to("log_campaigns#search")
    end

    it "routes to #new" do
      expect(:get => "/log_campaigns/new").to route_to("log_campaigns#new")
    end

    it "routes to #show" do
      expect(:get => "/log_campaigns/1").to route_to("log_campaigns#show", :id => "1")
    end

    it "routes to #all" do
      expect(:get => "/log_campaigns/1/all").to route_to("log_campaigns#all", :id => "1")
    end

    it "routes to #log" do
      expect(:get => "/log_campaigns/1/log").to route_to("log_campaigns#log", :id => "1")
    end

    it "routes to #error" do
      expect(:get => "/log_campaigns/1/error").to route_to("log_campaigns#error", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/log_campaigns/1/edit").to route_to("log_campaigns#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/log_campaigns").to route_to("log_campaigns#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/log_campaigns/1").to route_to("log_campaigns#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/log_campaigns/1").to route_to("log_campaigns#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/log_campaigns/1").to route_to("log_campaigns#destroy", :id => "1")
    end

  end
end
