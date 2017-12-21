require "rails_helper"

RSpec.describe StatusesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/status").to route_to("statuses#index")
    end

  end
end
