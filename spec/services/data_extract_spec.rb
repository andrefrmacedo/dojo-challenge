# frozen_string_literal: true

require 'rails_helper'

describe DataExtract do
  context 'Estract data from Overwatch API' do
    before :each do
      stub_request(:get, 'https://overwatch-api.net/api/v1/hero').
      to_return(
        status: 200,
        body: { total: 2, data: [{ id: 1 }, { id: 2 }] }.to_json,
        headers: { "Content-Type": 'application/json' }
      )

      stub_request(:get, 'https://overwatch-api.net/api/v1/hero/1').
      to_return(
        status: 200,
        body: {}.to_json,
        headers: { "Content-Type": 'application/json' }
      )

      stub_request(:get, 'https://overwatch-api.net/api/v1/hero/2').
      to_return(
        status: 200,
        body: {}.to_json,
        headers: { "Content-Type": 'application/json' }
      )
    end

    it 'extracts all heroes' do
      DataExtract.fetch_heroes
      expect(WebMock).to have_requested(:get, 'https://overwatch-api.net/api/v1/hero').once
      expect(WebMock).to have_requested(:get, 'https://overwatch-api.net/api/v1/hero/1').once
      expect(WebMock).to have_requested(:get, 'https://overwatch-api.net/api/v1/hero/2').once
    end
  end
end
