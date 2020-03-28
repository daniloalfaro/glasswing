class AddDeletedAtToIngredient < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :deleted_at, :datetime
    add_index :ingredients, :deleted_at
  end
end
