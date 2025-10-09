class Lineup < ApplicationRecord
  belongs_to :user
  belongs_to :contest
  has_many :lineup_players
  has_many :players, through: :lineup_players

  validate :lineup_salary_cap, :position_requirements, :entry_balance

  ERROR_TYPES = {
    TOO_MANY_PLAYERS: "Too many players with the position.",
    NOT_ENOUGH_PLAYERS: "Some positions uncovered.",
    POSITION_NONEXISTING: "Position does not exist."
  }

  FLEX_POSITIONS = 1

  POSITION_COUNTS = {
    QB: 1,
    RB: 2,
    WR: 3,
    TE: 1
  }

  private

  def lineup_salary_cap
      total_salary = players.reduce(0) { |acc, player| acc + player.salary }
      total_salary <= contest.salary_cap
  end

  def position_requirements
    @errors = []
    positions_left = POSITION_COUNTS.deep_dup
    flex_used = false
    players.each do |player|
      position = player.position.to_sym
      if positions_left[position].zero?
        flex_used ?
        @errors << { error_type: ERROR_TYPES[:TOO_MANY_PLAYERS], position: position } :
        flex_used = true
      elsif !POSITION_COUNTS[position]
        @errors << { error_type: ERROR_TYPES[:POSITION_NONEXISTING], position: position }
      else
        positions_left[position] -= 1
      end
    end

    if positions_left.values.any? { |count| count > 0 }
      @errors << { error_type: ERROR_TYPES[:NOT_ENOUGH_PLAYERS] }
    end

    raise "#{@errors}" unless @errors.empty?
  end

  def entry_balance
    user.balance >= contest.entry
  end
end
