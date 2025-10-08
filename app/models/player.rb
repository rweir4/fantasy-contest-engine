class Player < ApplicationRecord
  has_many :player_stats

  POSITIONS = {
    QB: "QB",
    RB: "RB",
    WR: "WR",
    TW: "TE"
  }
end
