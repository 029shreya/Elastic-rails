# frozen_string_literal: true

# spec/models/vertical_spec.rb
require 'rails_helper'

RSpec.describe Vertical, type: :model do
  describe 'associations' do
    it { should have_many(:categories) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:name) }

    it 'validates name uniqueness across categories' do
      FactoryBot.create(:category, name: 'Existing Category')
      vertical = FactoryBot.build(:vertical, name: 'Existing Category')

      expect(vertical).to be_invalid
      expect(vertical.errors[:name]).to include('A Category with the Existing Category already exists')
    end
  end
end
