module LineupHelpers
  def create_valid_player_set
    {
      qb: create(:player, position: 'QB', salary: 5000),
      rb1: create(:player, position: 'RB', salary: 4000),
      rb2: create(:player, position: 'RB', salary: 3000),
      wr1: create(:player, position: 'WR', salary: 3500),
      wr2: create(:player, position: 'WR', salary: 3000),
      wr3: create(:player, position: 'WR', salary: 2500),
      te: create(:player, position: 'TE', salary: 3000),
      flex: create(:player, position: 'RB', salary: 2000)
    }
  end
end
