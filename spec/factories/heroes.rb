# frozen_string_literal: true

FactoryBot.define do
  factory :hero do
    name { Faker::Games::Overwatch.hero }
    real_name { Faker::Name.name }
    health { Faker::Number.between(0, 999) }
    armour { Faker::Number.between(0, 999) }
    shield { Faker::Number.between(0, 999) }
  end
end
