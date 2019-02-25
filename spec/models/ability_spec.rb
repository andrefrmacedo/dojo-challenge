# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ability, type: :model do
  context 'validations' do
    subject { build :ability }

    it 'is valid with valid data' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a description' do
      subject.description = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a is_ultimate' do
      subject.is_ultimate = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a hero' do
      subject.hero = nil
      expect(subject).not_to be_valid
    end
  end
end
