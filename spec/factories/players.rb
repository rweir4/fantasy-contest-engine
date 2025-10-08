# spec/factories/players.rb
FactoryBot.define do
  factory :player do
    name { "Player #{rand(1000)}" }
    position { 'QB' }  # Default position
    salary { 5000 }    # Default salary
    team { 'KC' }      # Default team
  end
end
