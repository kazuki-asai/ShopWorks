class CustomerPurchaseHistory < ApplicationRecord
  belongs_to :shop
  belongs_to :customer
  belongs_to :product
end
