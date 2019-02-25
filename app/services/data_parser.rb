# frozen_string_literal: true

module DataParser
  extend self

  def parse(hero_list)
    hero_list.map do |hero|
      build_hero(hero)
    end
  end

  private

    def build_hero(data)
      {
        id: data['id'],
        name: data['name'],
        real_name: data['real_name'],
        health: data['health'],
        armour: data['armour'],
        shield: data['shield'],
        abilities: parse_abilities(data['abilities'], data['id'])
      }
    end

    def parse_abilities(ability_list, hero_id)
      ability_list.map do |ability|
        build_ability(ability).merge!(hero_id: hero_id)
      end
    end

    def build_ability(data)
      {
        id: data['id'],
        name: data['name'],
        description: data['description'],
        is_ultimate: data['is_ultimate']
      }
    end
end
