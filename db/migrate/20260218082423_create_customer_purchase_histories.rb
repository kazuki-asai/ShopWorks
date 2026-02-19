class CreateCustomerPurchaseHistories < ActiveRecord::Migration[8.1]
  def change
    create_table :customer_purchase_histories do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :shop, null: true, foreign_key: true
      t.integer :quantity
      t.integer :total_price
      t.datetime :ordered_at
      t.text :note

      t.timestamps
    end
  end
end
