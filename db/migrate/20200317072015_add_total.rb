class AddTotal < ActiveRecord::Migration[6.0]
  def change
    add_column :pizzas, :total, :decimal, precision: 12, scale: 2
    add_column :orders, :total, :decimal, precision: 12, scale: 2
  end
end
