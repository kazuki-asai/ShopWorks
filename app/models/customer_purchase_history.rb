class CustomerPurchaseHistory < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :shop

  has_one :order, dependent: :destroy
end
