# frozen_string_literal: true

class Size < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  def name_price
    name + ' ' + number_to_currency(price, locale: :en)
  end
end
