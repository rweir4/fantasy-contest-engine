class Contest < ApplicationRecord
  has_many :lineups

  validates :entry, :salary_cap, numericality: { greater_than: 0 }

  enum :status, [ :upcoming, :live, :completed ]
end
