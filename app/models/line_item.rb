class LineItem < ApplicationRecord
  belongs_to :pizza
  belongs_to :cart
  belongs_to :order

  def total_price
      self.quantity * self.pizza.price_final
    end
end
