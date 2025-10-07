require "rails_helper"

RSpec.describe PlayerStatsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/player_stats").to route_to("player_stats#index")
    end

    it "routes to #show" do
      expect(get: "/player_stats/1").to route_to("player_stats#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/player_stats").to route_to("player_stats#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/player_stats/1").to route_to("player_stats#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/player_stats/1").to route_to("player_stats#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/player_stats/1").to route_to("player_stats#destroy", id: "1")
    end
  end
end
