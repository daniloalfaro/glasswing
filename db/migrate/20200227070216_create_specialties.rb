class CreateSpecialties < ActiveRecord::Migration[6.0]
  def change
    create_table :specialties do |t|
      t.string :name, null: false, default: ''
      t.text :description
      t.decimal :price, precision: 12, scale: 2
      t.timestamps
    end
  end
end
