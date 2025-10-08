class Lineup < ApplicationRecord
  belongs_to :user
  belongs_to :contest
  has_many :lineup_players
  has_many :players, through: :lineup_players

  validates :total_score, numericality: { only_integer: true }, allow_nil: true
  validate :lineup_salary_cap, :position_requirements, :entry_balance

  POSITION_COUNTS = {
    QB: 1,
    RB: 2,
    WR: 3,
    TW: 1
  }

  private

  def lineup_salary_cap
    total_salary = players.reduce(0) { |acc, player| acc + player.salary }
    total_salary <= contest.salary_cap
  end

  # really dependent on setting up joins
  def position_requirements
    #   positions_left = POSITION_COUNTS.deep_dup
    #   players.each do |player|
    #     if positions_left[player.position] == 0
    #       raise "Too many players with the #{player.position} position"
    #     elsif !POSITION_COUNTS[player.position]
    #       raise "Position #{player.position} does not exist"
    #     end

    #     positions_left[player.position] -= 1
    #   end

    #   if positions_left.values.any? { |count| count > 0 }
    #     raise "Make sure all positions are covered."
    #   end
  end

  def entry_balance
    user.balance >= contest.entry
  end
end
