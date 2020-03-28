# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_and_belongs_to_many :parent_including_deleted, class_name: 'Pizza',
                                                     foreign_key: 'pizza_id',
                                                     with_deleted: true
  has_one_attached :image
  acts_as_paranoid
end
