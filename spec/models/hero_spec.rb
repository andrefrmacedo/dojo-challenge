# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hero, type: :model do
  context 'validations' do
    subject { build :hero }

    it 'is valid with valid data' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a real_name' do
      subject.real_name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without health value' do
      subject.health = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without armour value' do
      subject.armour = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without shield value' do
      subject.shield = nil
      expect(subject).not_to be_valid
    end
  end
end
