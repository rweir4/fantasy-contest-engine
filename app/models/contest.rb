class Contest < ApplicationRecord
  enum :status, [ :upcoming, :live, :completed ]
end
