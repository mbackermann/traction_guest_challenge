FactoryBot.define do
  factory :track do
    guest
    room
    status { rand(2) }
  end
end
