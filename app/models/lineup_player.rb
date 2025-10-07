class LineupPlayer < ApplicationRecord
  belongs_to :lineup
  belongs_to :player
end
