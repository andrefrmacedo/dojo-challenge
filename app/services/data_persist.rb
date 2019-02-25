# frozen_string_literal: true

module DataPersist
  extend self

  def persist(hero_data)
    hero_data.map do |hero|
      persist_hero(hero.except(:abilities))
      persist_abilities(hero[:abilities])
    end
  end

  private

    def persist_hero(hero)
      record = Hero.find_by(id: hero[:id])
      record ? record.update!(hero.except(:id)) : Hero.create!(hero)
    end

    def persist_abilities(abilities)
      abilities.each do |ability|
        record = Ability.find_by(id: ability[:id])
        record ? record.update!(ability.except(:id)) : Ability.create!(ability)
      end
    end
end
