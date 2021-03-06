class Specialty < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  acts_as_paranoid


  def name_price
    name + ' ' + number_to_currency(price, locale: :en)
  end
end
