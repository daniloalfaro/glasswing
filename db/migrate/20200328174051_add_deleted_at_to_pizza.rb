class AddDeletedAtToPizza < ActiveRecord::Migration[6.0]
  def change
    add_column :pizzas, :deleted_at, :datetime
    add_index :pizzas, :deleted_at
  end
end
