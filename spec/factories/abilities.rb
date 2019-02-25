# frozen_string_literal: true

FactoryBot.define do
  factory :ability do
    name { Faker::Games::Pokemon.move }
    description { Faker::Lorem.sentence }
    is_ultimate { Faker::Boolean.boolean }
    hero { create :hero }
  end
end
