# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AbilitiesController, type: :controller do
  let!(:hero) { create :hero }
  let!(:ability1) { create :ability, hero: hero }
  let!(:ability2) { create :ability, hero: hero }

  context 'GET #index all abilities' do
    it 'returns http success' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'returns 2 abilities' do
      get :index

      expect(json_response['data'].count).to eq(2)
    end

    it 'returns the correct data' do
      get :index

      first_ability = json_response['data'].first
      first_ability_attr = json_response['data'].first['attributes']
      second_ability = json_response['data'].second
      second_ability_attr = json_response['data'].second['attributes']

      expect(first_ability['id']).to eq(ability1.id.to_s)
      expect(first_ability['type']).to eq('abilities')
      expect(first_ability_attr['name']).to eq(ability1.name)
      expect(first_ability_attr['description']).to eq(ability1.description)
      expect(first_ability_attr['is-ultimate']).to eq(ability1.is_ultimate)

      expect(second_ability['id']).to eq(ability2.id.to_s)
      expect(second_ability['type']).to eq('abilities')
      expect(second_ability_attr['name']).to eq(ability2.name)
      expect(second_ability_attr['description']).to eq(ability2.description)
      expect(second_ability_attr['is-ultimate']).to eq(ability2.is_ultimate)
    end

    it 'returns the correct format' do
      get :index

      first_ability = json_response['data'].first

      expect(json_response).to have_key('data')
      expect(json_response['data']).to be_an_instance_of(Array)
      expect(first_ability).to have_key('id')
      expect(first_ability).to have_key('type')
      expect(first_ability).to have_key('attributes')
      expect(first_ability).to have_key('relationships')
      expect(first_ability['relationships']).to have_key('hero')
    end
  end

  context 'GET #index all abilities from hero' do
    it 'returns http success' do
      get :index, params: { hero_id: hero.id }

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct data' do
      get :index, params: { hero_id: hero.id }

      hero_data = json_response['data']
      hero_attr = json_response['data']['attributes']

      first_ability = json_response['included'].first
      first_ability_attr = json_response['included'].first['attributes']
      second_ability = json_response['included'].second
      second_ability_attr = json_response['included'].second['attributes']

      expect(hero_data['id']).to eq(hero.id.to_s)
      expect(hero_data['type']).to eq('heroes')
      expect(hero_attr['name']).to eq(hero.name)
      expect(hero_attr['real-name']).to eq(hero.real_name)
      expect(hero_attr['health']).to eq(hero.health)
      expect(hero_attr['armour']).to eq(hero.armour)
      expect(hero_attr['shield']).to eq(hero.shield)

      expect(first_ability['id']).to eq(ability1.id.to_s)
      expect(first_ability['type']).to eq('abilities')
      expect(first_ability_attr['name']).to eq(ability1.name)
      expect(first_ability_attr['description']).to eq(ability1.description)
      expect(first_ability_attr['is-ultimate']).to eq(ability1.is_ultimate)

      expect(second_ability['id']).to eq(ability2.id.to_s)
      expect(second_ability['type']).to eq('abilities')
      expect(second_ability_attr['name']).to eq(ability2.name)
      expect(second_ability_attr['description']).to eq(ability2.description)
      expect(second_ability_attr['is-ultimate']).to eq(ability2.is_ultimate)
    end

    it 'returns the correct format' do
      get :index, params: { hero_id: hero.id }

      first_ability = json_response['included'].first

      expect(json_response).to have_key('data')
      expect(json_response).to have_key('included')
      expect(json_response['included']).to be_an_instance_of(Array)
      expect(first_ability).to have_key('id')
      expect(first_ability).to have_key('type')
      expect(first_ability).to have_key('attributes')
      expect(first_ability).to have_key('relationships')
      expect(first_ability['relationships']).to have_key('hero')
    end

    it 'returns http not_found' do
      get :index, params: { hero_id: hero.id + 1 }

      expect(response).to have_http_status(:not_found)
    end

    it 'returns correct error format' do
      get :index, params: { hero_id: hero.id + 1 }

      expect(json_response).to have_key('error')
      expect(json_response['error']).to have_key('title')
      expect(json_response['error']).to have_key('detail')
      expect(json_response['error']).to have_key('status')
    end

    it 'returns correct error message' do
      get :index, params: { hero_id: hero.id + 1 }

      expect(json_response['error']['status']).to eq(404)
      expect(json_response['error']['title']).to eq(I18n.t('errors.not_found.title'))
      expect(json_response['error']['detail']).to eq(I18n.t('errors.not_found.detail'))
    end
  end

  context 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: ability1.id }

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct data' do
      get :show, params: { id: ability1.id }

      hero = json_response['data']
      hero_attr = json_response['data']['attributes']

      expect(hero['id']).to eq(ability1.id.to_s)
      expect(hero['type']).to eq('abilities')
      expect(hero_attr['name']).to eq(ability1.name)
      expect(hero_attr['description']).to eq(ability1.description)
      expect(hero_attr['is-ultimate']).to eq(ability1.is_ultimate)
    end

    it 'returns the correct format' do
      get :show, params: { id: ability1.id }

      hero = json_response['data']

      expect(json_response).to have_key('data')
      expect(hero).to have_key('id')
      expect(hero).to have_key('type')
      expect(hero).to have_key('attributes')
      expect(hero).to have_key('relationships')
      expect(hero['relationships']).to have_key('hero')
    end

    it 'returns http not_found' do
      get :show, params: { id: ability2.id + 1 }

      expect(response).to have_http_status(:not_found)
    end

    it 'returns correct error format' do
      get :show, params: { id: ability2.id + 1 }

      expect(json_response).to have_key('error')
      expect(json_response['error']).to have_key('title')
      expect(json_response['error']).to have_key('detail')
      expect(json_response['error']).to have_key('status')
    end

    it 'returns correct error message' do
      get :show, params: { id: ability2.id + 1 }

      expect(json_response['error']['status']).to eq(404)
      expect(json_response['error']['title']).to eq(I18n.t('errors.not_found.title'))
      expect(json_response['error']['detail']).to eq(I18n.t('errors.not_found.detail'))
    end
  end
end
