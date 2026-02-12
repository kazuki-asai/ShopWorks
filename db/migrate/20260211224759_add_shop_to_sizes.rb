class AddShopToSizes < ActiveRecord::Migration[8.1]
  def change
    add_reference :sizes, :shop, null: true, foreign_key: true
  end
end
