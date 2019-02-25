# frozen_string_literal: true

class AbilitySerializer < ActiveModel::Serializer
  type 'abilities'

  attributes :id, :name, :description, :is_ultimate

  belongs_to :hero
end
