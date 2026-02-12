class Size < ApplicationRecord
  default_scope { order(:position) }

  belongs_to :shop
  has_many :product_sizes, dependent: :destroy
  has_many :products, through: :product_sizes
end
