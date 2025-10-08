class Lineup < ApplicationRecord
  belongs_to :user
  belongs_to :contest
  has_many :lineup_players
  has_many :players, through: :lineup_players

  validates :total_score, numericality: { only_integer: true }, allow_nil: true
  validate :lineup_salary_cap, :position_requirements, :entry_balance

  ERROR_TYPES = {
    TOO_MANY_PLAYERS: "Too many players with the position.",
    NOT_ENOUGH_PLAYERS: "Some positions uncovered.",
    POSITION_NONEXISTING: "Position does not exist."
  }

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

  def position_requirements
    @errors = []
    positions_left = POSITION_COUNTS.deep_dup
    players.each do |player|
      if positions_left[player.position] == 0
        @errors << { error_type: ERROR_TYPES[:TOO_MANY_PLAYERS], position: player.position }
      elsif !POSITION_COUNTS[player.position]
        @errors << { error_type: ERROR_TYPES[:POSITION_NONEXISTING], position: player.position }
      end

      positions_left[player.position] -= 1
    end

    if positions_left.values.any? { |count| count > 0 }
      @errors << { error_type: ERROR_TYPES[:NOT_ENOUGH_PLAYERS] }
    end

    raise "#{@errors.inspect}" unless @errors.empty?
  end

  def entry_balance
    user.balance >= contest.entry
  end
end
