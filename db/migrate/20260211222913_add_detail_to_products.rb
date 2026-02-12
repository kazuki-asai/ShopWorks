class AddDetailToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :detail, :text
  end
end
