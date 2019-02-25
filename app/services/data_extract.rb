# frozen_string_literal: true

module DataExtract
  extend self

  def fetch_heroes
    hero_list.map do |hero|
      fetch_hero(hero['id'])
    end
  end

  private

    def hero_list
      resources = OverwatchApi.new.hero
      raise "Got #{resources.code} fetching all heroes" if resources.code > 400
      resources.parsed_response['data']
    end

    def fetch_hero(id)
      resource = OverwatchApi.new.hero(id)
      raise "Got #{resource.code} fetching hero id: #{id}" if resource.code > 400
      resource.parsed_response
    end
end
