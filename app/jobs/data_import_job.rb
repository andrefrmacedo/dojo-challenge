# frozen_string_literal: true

class DataImportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    hero_list = DataExtract.fetch_heroes
    hero_data = DataParser.parse(hero_list)
    DataPersist.persist(hero_data)
  end
end
