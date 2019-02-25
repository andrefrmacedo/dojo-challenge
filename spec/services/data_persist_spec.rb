# frozen_string_literal: true

require 'rails_helper'

describe DataPersist do
  context 'persist heroes and abilities data' do
    it 'creates new heroes and abilities' do
      hero_count = Hero.count
      ability_count = Ability.count
      DataPersist.persist(hero_data)

      expect(Hero.count).not_to eq(hero_count)
      expect(Ability.count).not_to eq(ability_count)
      expect(Hero.count).to eq(1)
      expect(Ability.count).to eq(2)
      expect(Hero.first.id).to eq(hero_data.first[:id])
      expect(Ability.first.id).to eq(hero_data.first[:abilities].first[:id])
      expect(Ability.second.id).to eq(hero_data.first[:abilities].second[:id])
    end
  end
end


def hero_data
  [{
    id: 1,
    name: 'Andre',
    real_name: 'Andre Macedo',
    health: 200,
    armour: 100,
    shield: 0,
    abilities: [
      {
        id: 1,
        hero_id: 1,
        name: 'Ultra Fun Ability',
        description: '1 shot ability',
        is_ultimate: true
      },
      {
        id: 2,
        hero_id: 1,
        name: 'Ultra Boring Ability',
        description: '2 shot ability',
        is_ultimate: false
      }
    ]
  }]
end
