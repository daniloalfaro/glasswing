# frozen_string_literal: true

class Pizza < ApplicationRecord
  belongs_to :user
  belongs_to :size
  belongs_to :specialty
  has_and_belongs_to_many :ingredients
  has_many :line_items, dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :ingredients, presence: true, if: -> { specialty_id.blank? }

  def ingredient_names
    names = nil
    return unless ingredients.any?

    names = []
    ingredients.each { |i| names.push i.name }
    names.join(', ')
  end

  def price_final
    prices = []
    ingredients.each { |i| prices.push i.price }
    prices.push size.price
    prices.push specialty.price unless specialty.nil?
    prices.sum
  end
end
