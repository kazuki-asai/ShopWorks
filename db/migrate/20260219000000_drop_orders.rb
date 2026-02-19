class DropOrders < ActiveRecord::Migration[8.1]
  def up
    drop_table :orders
  end

  def down
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.integer :quantity
      t.integer :total_price
      t.datetime :ordered_at
      t.text :note
      t.timestamps
    end
  end
end
