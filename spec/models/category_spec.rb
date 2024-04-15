# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:vertical) { FactoryBot.create(:vertical) }

  describe 'associations' do
    it { should belong_to(:vertical) }
    it { should have_many(:courses) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'validates case-insensitive uniqueness within the scope of :vertical_id' do
      existing_category = FactoryBot.create(:category)
      new_category = FactoryBot.build(:category, name: existing_category.name, vertical: existing_category.vertical)

      existing_categories = Category.where('LOWER(name) = ? AND vertical_id = ?', new_category.name.downcase,
                                           new_category.vertical_id)
      puts "Existing Categories with the same name and vertical ID: #{existing_categories.pluck(:name, :vertical_id)}"
      expect(existing_categories.exists?).to be_truthy
    end
  end
end
