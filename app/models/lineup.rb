class Lineup < ApplicationRecord
  belongs_to :user
  belongs_to :contest
  has_many :lineup_players
  has_many :players, through: :lineup_players
end
