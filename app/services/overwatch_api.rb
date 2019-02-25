# frozen_string_literal: true

class OverwatchApi
  include HTTParty
  base_uri 'https://overwatch-api.net/api/v1'

  def hero(id = nil)
    url = id ? "/hero/#{id}" : '/hero'
    self.class.get(url)
  end

  def ability(id = nil)
    url = id ? "/ability/#{id}" : '/ability'
    self.class.get(url)
  end
end
