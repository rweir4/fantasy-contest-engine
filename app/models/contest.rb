class Contest < ApplicationRecord
  has_many :lineups

  enum :status, [ :upcoming, :live, :completed ]
end
