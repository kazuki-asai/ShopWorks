class Order < ApplicationRecord
  belongs_to :customer_purchase_history

  enum :payment_status, { pending: 0, paid: 1, failed: 2, refunded: 3 }
end
