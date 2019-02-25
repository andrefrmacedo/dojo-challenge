# frozen_string_literal: true

class Ability < ApplicationRecord
  belongs_to :hero

  validates :name, :description, presence: true
  validates :is_ultimate, inclusion: { in: [true, false] }
end
