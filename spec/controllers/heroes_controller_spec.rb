# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeroesController, type: :controller do
  let!(:hero1) { create :hero }
  let!(:hero2) { create :hero }

  context 'GET #index' do
    it 'returns http success' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'returns 2 heroes' do
      get :index

      expect(json_response['data'].count).to eq(2)
    end

    it 'returns the correct data' do
      get :index

      first_hero = json_response['data'].first
      first_hero_attr = json_response['data'].first['attributes']
      second_hero = json_response['data'].second
      second_hero_attr = json_response['data'].second['attributes']

      expect(first_hero['id']).to eq(hero1.id.to_s)
      expect(first_hero['type']).to eq('heroes')
      expect(first_hero_attr['name']).to eq(hero1.name)
      expect(first_hero_attr['real-name']).to eq(hero1.real_name)
      expect(first_hero_attr['health']).to eq(hero1.health)
      expect(first_hero_attr['armour']).to eq(hero1.armour)
      expect(first_hero_attr['shield']).to eq(hero1.shield)

      expect(second_hero['id']).to eq(hero2.id.to_s)
      expect(second_hero['type']).to eq('heroes')
      expect(second_hero_attr['name']).to eq(hero2.name)
      expect(second_hero_attr['real-name']).to eq(hero2.real_name)
      expect(second_hero_attr['health']).to eq(hero2.health)
      expect(second_hero_attr['armour']).to eq(hero2.armour)
      expect(second_hero_attr['shield']).to eq(hero2.shield)
    end

    it 'returns the correct format' do
      get :index

      first_hero = json_response['data'].first

      expect(json_response).to have_key('data')
      expect(json_response['data']).to be_an_instance_of(Array)
      expect(first_hero).to have_key('id')
      expect(first_hero).to have_key('type')
      expect(first_hero).to have_key('attributes')
      expect(first_hero).to have_key('relationships')
      expect(first_hero['relationships']).to have_key('abilities')
    end
  end

  context 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: hero1.id }

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct data' do
      get :show, params: { id: hero1.id }

      hero = json_response['data']
      hero_attr = json_response['data']['attributes']

      expect(hero['id']).to eq(hero1.id.to_s)
      expect(hero['type']).to eq('heroes')
      expect(hero_attr['name']).to eq(hero1.name)
      expect(hero_attr['real-name']).to eq(hero1.real_name)
      expect(hero_attr['health']).to eq(hero1.health)
      expect(hero_attr['armour']).to eq(hero1.armour)
      expect(hero_attr['shield']).to eq(hero1.shield)
    end

    it 'returns the correct format' do
      get :show, params: { id: hero1.id }

      hero = json_response['data']

      expect(json_response).to have_key('data')
      expect(hero).to have_key('id')
      expect(hero).to have_key('type')
      expect(hero).to have_key('attributes')
      expect(hero).to have_key('relationships')
      expect(hero['relationships']).to have_key('abilities')
    end

    it 'returns http not_found' do
      get :show, params: { id: hero2.id + 1 }

      expect(response).to have_http_status(:not_found)
    end

    it 'returns correct error format' do
      get :show, params: { id: hero2.id + 1 }

      expect(json_response).to have_key('error')
      expect(json_response['error']).to have_key('title')
      expect(json_response['error']).to have_key('detail')
      expect(json_response['error']).to have_key('status')
    end

    it 'returns correct error message' do
      get :show, params: { id: hero2.id + 1 }

      expect(json_response['error']['status']).to eq(404)
      expect(json_response['error']['title']).to eq(I18n.t('errors.not_found.title'))
      expect(json_response['error']['detail']).to eq(I18n.t('errors.not_found.detail'))
    end
  end
end
