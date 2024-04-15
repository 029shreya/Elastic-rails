# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
  end

  describe 'validations' do
    it 'validates uniqueness of name within the scope of category_id' do
      category = FactoryBot.create(:category)
      existing_course = FactoryBot.create(:course, category: category)

      new_course = FactoryBot.build(:course, name: existing_course.name, category: category)

      expect(new_course).to be_invalid
      expect(new_course.errors[:name]).to include('has already been taken')
    end
  end
end
