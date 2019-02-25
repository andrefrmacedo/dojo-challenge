# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataImportJob, type: :job do
  context 'runs the job' do
    it 'imports hero and abilities data' do
      stub_request(:get, 'https://overwatch-api.net/api/v1/hero').
      to_return(
        status: 200,
        body: { total: 1, data: [{ id: 1 }] }.to_json,
        headers: { "Content-Type": 'application/json' }
      )

      stub_request(:get, 'https://overwatch-api.net/api/v1/hero/1').
      to_return(
        status: 200,
        body: hero.to_json,
        headers: { "Content-Type": 'application/json' }
      )

      DataImportJob.new.perform_now

      expect(Hero.count).to eq(1)
      expect(Ability.count).to eq(2)
      expect(Hero.first.id).to eq(hero[:id])
      expect(Ability.first.id).to eq(hero[:abilities].first[:id])
      expect(Ability.second.id).to eq(hero[:abilities].second[:id])
    end
  end
end

def hero
  {
    id: 1,
    name: 'Andre',
    real_name: 'Andre Macedo',
    health: 200,
    armour: 100,
    shield: 0,
    abilities: [
      {
        id: 1,
        name: 'Ultra Fun Ability',
        description: '1 shot ability',
        is_ultimate: true
      },
      {
        id: 2,
        name: 'Ultra Boring Ability',
        description: '2 shot ability',
        is_ultimate: false
      }
    ]
  }
end
