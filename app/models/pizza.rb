# frozen_string_literal: true

class Pizza < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :size
  belongs_to :size_including_deleted, class_name: 'Size',
                                      foreign_key: 'size_id',
                                      with_deleted: true

  belongs_to :specialty
  belongs_to :specialty_including_deleted, class_name: 'Specialty',
                                           foreign_key: 'specialty_id',
                                           with_deleted: true

  has_and_belongs_to_many :ingredients

  has_many :line_items, dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :ingredients, presence: true, if: -> { specialty_id.blank? }

  def ingredient_names
    names = nil
    return unless ingredients.with_deleted.any?

    names = []
    ingredients.with_deleted.each { |i| names.push i.name }
    names.join(', ')
  end

  def price_final
    prices = []
    ingredients.with_deleted.each { |i| prices.push i.price }
    prices.push size.price
    prices.push specialty.price unless specialty.nil?
    prices.sum
  end
end

Order.includes(:pizzas, :ingredients).order('COUNT(ingredients.id) DESC')
