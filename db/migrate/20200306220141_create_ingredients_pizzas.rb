class CreateIngredientsPizzas < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients_pizzas do |t|
      t.belongs_to :pizza
      t.belongs_to :ingredient
      t.timestamps
    end
  end
end
