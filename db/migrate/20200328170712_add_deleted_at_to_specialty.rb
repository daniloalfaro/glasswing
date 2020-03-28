class AddDeletedAtToSpecialty < ActiveRecord::Migration[6.0]
  def change
    add_column :specialties, :deleted_at, :datetime
    add_index :specialties, :deleted_at
  end
end
