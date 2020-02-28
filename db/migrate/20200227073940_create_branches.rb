class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.string :name, null: false, default: ''
      t.text :address
      t.timestamps
    end
  end
end
