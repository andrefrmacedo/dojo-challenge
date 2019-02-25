# frozen_string_literal: true

class HeroSerializer < ActiveModel::Serializer
  type 'heroes'

  attributes :name, :real_name, :health, :armour, :shield

  has_many :abilities
end
