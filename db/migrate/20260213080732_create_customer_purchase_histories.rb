class CreateCustomerPurchaseHistories < ActiveRecord::Migration[8.1]
  def change
    create_table :customer_purchase_histories do |t|
      t.references :shop, null: true, foreign_key: true, comment: "購入が発生したショップ"
      t.references :customer, null: true, foreign_key: true, comment: "購入した顧客"
      t.references :product, null: true, foreign_key: true, comment: "紐付く商品（削除されても履歴は残す）"

      # スナップショット
      t.string  :product_name, comment: "購入時の商品名スナップショット"
      t.string  :sku,          comment: "購入時のSKU（販売単位識別子）"

      # 金額
      t.integer :unit_price,     comment: "購入時単価（円）"
      t.integer :count,          comment: "購入数量"
      t.integer :subtotal_price, comment: "小計金額（unit_price × count）"
      t.integer :tax,            comment: "税額"
      t.integer :discount,       comment: "割引額"

      # 注文
      t.string  :order_number,                comment: "注文番号（同一注文のグルーピング用）"
      t.integer :status, default: 0, null: false, comment: "購入状態（0:購入済 / 1:キャンセル / 2:返金）"

      # 日時
      t.datetime :purchased_at, comment: "実際の購入日時（決済完了日時）"

      t.timestamps
    end
  end
end
