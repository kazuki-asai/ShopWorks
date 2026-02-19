class CreateOrdersForStripe < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :customer_purchase_history, null: false, foreign_key: true
      t.string :stripe_checkout_session_id
      t.string :stripe_payment_intent_id
      t.integer :payment_status, default: 0, null: false
      t.string :customer_email
      t.timestamps
    end

    add_index :orders, :stripe_checkout_session_id, unique: true
    add_index :orders, :payment_status
  end
end
