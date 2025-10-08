require 'rails_helper'

RSpec.describe "/lineups", type: :request do
  before do
    10.times do
      Player.create!(
        name: Faker::Sports::Football.player,
        position: [ 'QB', 'RB', 'WR', 'TE' ].sample,
        salary: rand(3000..10000),
        team: Faker::Sports::Football.team
      )
    end
  end

  let(:lineup_player_ids) { create_valid_player_set.values.map(&:id) }
  let(:user) { User.create!({ name: 'Rebecca Weir', balance: 500.00 }) }
  let(:contest) {
      Contest.create!({
      name: 'First Contest',
      entry: 100.00,
      salary_cap: 1000,
      start_time: DateTime.now,
      status: Contest.statuses['live'],
      cached_leader_id: nil
    })
  }

  let(:valid_attributes) {
    {
      user_id: user.id,
      total_score: 100
    }
  }

  let(:invalid_attributes) {
    {
      user_id: user.id,
      total_score: 'one hundred'
    }
  }
  let(:valid_headers) { {} }

  describe "GET contest/index" do
    it "renders a successful response" do
      contest.lineups.create!(valid_attributes)
      get contest_lineups_url(contest), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      lineup = contest.lineups.create!(valid_attributes)
      lineup.player_ids = lineup_player_ids
      get lineup_url(lineup), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /contest/create" do
    context "with valid parameters" do
      it "creates a new Lineup" do
        expect {
          post contest_lineups_url(contest),
               params: { lineup: valid_attributes, player_ids: lineup_player_ids }, headers: valid_headers, as: :json
        }.to change(Lineup, :count).by(1)
      end

      it "validates position requirements" do
        lineup = contest.lineups.create!(user: user)
        lineup.player_ids = lineup_player_ids

        expect(lineup).to be_valid
      end

      it "renders a JSON response with the new lineup" do
        post contest_lineups_url(contest),
             params: { lineup: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Lineup" do
        expect {
          post contest_lineups_url(contest),
               params: { lineup: invalid_attributes }, as: :json
        }.to change(Lineup, :count).by(0)
      end

      it "fails with too many QBs" do
        extra_qb = create(:player, position: 'QB', salary: 5000)

        lineup = contest.lineups.create!(user: user)
        lineup.player_ids = lineup_player_ids << extra_qb.id

        expect { lineup.position_requirements }.to raise_error(/Make sure all positions are covered./)
      end

      it "renders a JSON response with errors for the new lineup" do
        post contest_lineups_url(contest),
             params: { lineup: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_content)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { total_score: 500 } }

      it "updates the requested lineup" do
        lineup = contest.lineups.create!(valid_attributes)
        lineup.player_ids = lineup_player_ids
        patch lineup_url(lineup),
              params: { lineup: new_attributes }, headers: valid_headers, as: :json
        lineup.reload
        expect(lineup.total_score).to eq(500)
      end

      it "renders a JSON response with the lineup" do
        lineup = contest.lineups.create!(valid_attributes)
        lineup.player_ids = lineup_player_ids
        patch lineup_url(lineup),
              params: { lineup: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the lineup" do
        lineup = contest.lineups.create!(valid_attributes)
        lineup.player_ids = lineup_player_ids
        patch lineup_url(lineup),
              params: { lineup: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_content)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested lineup" do
      lineup = contest.lineups.create!(valid_attributes)
      lineup.player_ids = lineup_player_ids
      expect {
        delete lineup_url(lineup), headers: valid_headers, as: :json
      }.to change(Lineup, :count).by(-1)
    end
  end
end
