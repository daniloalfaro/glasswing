class CreateSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :sizes do |t|
      t.string :name, null: false, default: ''
      t.decimal :price, precision: 12, scale: 2
      t.timestamps
    end
  end
end
