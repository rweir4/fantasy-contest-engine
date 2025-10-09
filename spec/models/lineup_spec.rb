require 'rails_helper'

RSpec.describe Lineup, type: :model do
  # let(:user) { User.create!({ name: 'Rebecca Weir', balance: 500.00 }) }
  # let(:lineup_player_ids) { create_valid_player_set.values.map(&:id) }
  # let(:contest) {
  #   Contest.create!({
  #     name: 'First Contest',
  #     entry: 100.00,
  #     salary_cap: 1000,
  #     start_time: DateTime.now,
  #     status: Contest.statuses['live'],
  #     cached_leader_id: nil
  #   })
  # }
  # let(:valid_attributes) {
  #   {
  #     user_id: user.id,
  #     total_score: 100,
  #     player_ids: lineup_player_ids
  #   }
  # }

  it "fails with too many QBs" do
    extra_qb = create(:player, position: 'QB', salary: 5000)

    lineup = contest.lineups.create!(user: user)
    lineup.player_ids = lineup_player_ids << extra_qb.id

    expect { lineup.position_requirements }.to raise_error(/Make sure all positions are covered./)
  end
end
