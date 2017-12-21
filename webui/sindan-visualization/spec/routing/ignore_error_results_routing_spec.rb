require "rails_helper"

RSpec.describe IgnoreErrorResultsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ignore_error_results").to route_to("ignore_error_results#index")
    end

    it "routes to #new" do
      expect(:get => "/ignore_error_results/new").to route_to("ignore_error_results#new")
    end

    it "routes to #show" do
      expect(:get => "/ignore_error_results/1").to route_to("ignore_error_results#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ignore_error_results/1/edit").to route_to("ignore_error_results#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ignore_error_results").to route_to("ignore_error_results#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ignore_error_results/1").to route_to("ignore_error_results#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ignore_error_results/1").to route_to("ignore_error_results#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ignore_error_results/1").to route_to("ignore_error_results#destroy", :id => "1")
    end

  end
end
