# frozen_string_literal: true

# app/models/category.rb

class Category < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :vertical
  has_many :courses

  validates :name, presence: true
  validates :name, uniqueness: { scope: :vertical_id, case_sensitive: false }

  validate :name_unique_across_verticals

  accepts_nested_attributes_for :courses

  index_name "categories_#{Rails.env}"

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, type: 'text'
      indexes :state, type: 'keyword'
    end
  end

  def as_indexed_json(_options = {})
    as_json(only: %i[name state])
  end

  def as_json(options = {})
    super(options.merge(include: :courses))
  end

  private

  def name_unique_across_verticals
    return unless Vertical.exists?(name: name)

    errors.add(:name, "A vertical with #{name} already exists")
  end
end
