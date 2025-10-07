# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
def generate_stats(position)
  case position
  when 'QB'
    {
      'passing_yards' => rand(150..400),
      'passing_tds' => rand(0..5),
      'interceptions' => rand(0..3)
    }
  when 'RB'
    {
      'rushing_yards' => rand(30..150),
      'rushing_tds' => rand(0..3),
      'receptions' => rand(2..8),
      'receiving_yards' => rand(10..80),
      'receiving_tds' => rand(0..2)
    }
  when 'WR'
    {
      'receptions' => rand(3..12),
      'receiving_yards' => rand(40..150),
      'receiving_tds' => rand(0..3)
    }
  when 'TE'
    {
      'receptions' => rand(2..10),
      'receiving_yards' => rand(30..120),
      'receiving_tds' => rand(0..2)
    }
  end
end

20.times do
  User.create!(
    name: Faker::Name.name,
    balance: rand(100..1000)
  )
end

40.times do
  Player.create!(
    name: Faker::Sports::Football.player,
    position: [ 'QB', 'RB', 'WR', 'TE' ].sample,
    salary: rand(3000..10000),
    team: Faker::Sports::Football.team
  )
end

10.times do
  Contest.create!(
    name: Faker::Sports::Football.competition,
    entry: rand(1.0..20.0).round(2),
    salary_cap: rand(400..800),
    start_time: Date.today - rand(365),
    status: Contest.statuses.keys.sample,
    cached_leader_id: nil
  )
end

Player.all.map do |player|
  PlayerStat.create!(
    player: player,
    game_week: rand(1..10),
    stats: generate_stats(player.position),
    fantasy_points: rand(5.0..30.0).round(2),
  )
end
