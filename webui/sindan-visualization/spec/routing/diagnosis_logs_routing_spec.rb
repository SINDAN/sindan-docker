require "rails_helper"

RSpec.describe DiagnosisLogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/diagnosis_logs").to route_to("diagnosis_logs#index")
    end

    it "routes to #new" do
      expect(:get => "/diagnosis_logs/new").to route_to("diagnosis_logs#new")
    end

    it "routes to #show" do
      expect(:get => "/diagnosis_logs/1").to route_to("diagnosis_logs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/diagnosis_logs/1/edit").to route_to("diagnosis_logs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/diagnosis_logs").to route_to("diagnosis_logs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/diagnosis_logs/1").to route_to("diagnosis_logs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/diagnosis_logs/1").to route_to("diagnosis_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/diagnosis_logs/1").to route_to("diagnosis_logs#destroy", :id => "1")
    end

  end
end
