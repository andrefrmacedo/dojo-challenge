# frozen_string_literal: true

require 'rails_helper'

describe DataParser do
  context 'parses data' do
    it 'parses data in the correct format' do
      result = DataParser.parse(hero_list)
      hero = result.first
      abilities = result.first[:abilities]

      expect(hero[:id]).to eq(hero_list.first['id'])
      expect(hero[:name]).to eq(hero_list.first['name'])
      expect(hero[:real_name]).to eq(hero_list.first['real_name'])
      expect(hero[:health]).to eq(hero_list.first['health'])
      expect(hero[:armour]).to eq(hero_list.first['armour'])
      expect(hero[:shield]).to eq(hero_list.first['shield'])
      expect(hero[:some_other_value]).to eq(nil)

      expect(abilities.count).to eq(2)
      expect(abilities.first[:id]).to eq(hero_list.first['abilities'].first['id'])
      expect(abilities.first[:name]).to eq(hero_list.first['abilities'].first['name'])
      expect(abilities.second[:description]).to eq(hero_list.first['abilities'].second['description'])
      expect(abilities.second[:is_ultimate]).to eq(hero_list.first['abilities'].second['is_ultimate'])
      expect(abilities.first[:some_value]).to eq(nil)
      expect(abilities.first[:hero_id]).to eq(hero_list.first['id'])
      expect(abilities.second[:hero_id]).to eq(hero_list.first['id'])
    end
  end
end

def hero_list
  [{
    'id' => 1,
    'name' => 'Andre',
    'real_name' => 'Andre Macedo',
    'health' => 200,
    'armour' => 100,
    'shield' => 0,
    'some_other_value' => 200,
    'abilities' => [
      {
        'id' => 1,
        'name' => 'Ultra Fun Ability',
        'description' => '1 shot ability',
        'is_ultimate' => true,
        'some_value' => 'kills everytime'
      },
      {
        'id' => 2,
        'name' => 'Ultra Boring Ability',
        'description' => '2 shot ability',
        'is_ultimate' => false
      }
    ]
  }]
end
