require "rails_helper"

RSpec.describe LineupPlayersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/lineup_players").to route_to("lineup_players#index")
    end

    it "routes to #show" do
      expect(get: "/lineup_players/1").to route_to("lineup_players#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/lineup_players").to route_to("lineup_players#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/lineup_players/1").to route_to("lineup_players#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/lineup_players/1").to route_to("lineup_players#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/lineup_players/1").to route_to("lineup_players#destroy", id: "1")
    end
  end
end
