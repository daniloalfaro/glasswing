class LineItem < ApplicationRecord
  belongs_to :pizza
  belongs_to :pizza_including_deleted, class_name: 'Pizza',
                                      foreign_key: 'pizza_id',
                                      with_deleted: true

  belongs_to :cart
  belongs_to :order

  def total_price
      self.quantity * self.pizza_including_deleted.price_final
    end
end
