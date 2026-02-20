class AddCodeToShops < ActiveRecord::Migration[8.1]
  def change
    add_column :shops, :code, :string
    add_index :shops, :code, unique: true
  end
end
