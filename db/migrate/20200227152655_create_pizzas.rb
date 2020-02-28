class CreatePizzas < ActiveRecord::Migration[6.0]
  def change
    create_table :pizzas do |t|
      t.integer :user_id, null: false
      t.string :name
      t.text :description
      t.integer :specialty_id, null: true
      t.integer :size_id, null: false
      t.timestamps
    end
  end
end
