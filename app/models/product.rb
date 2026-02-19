class Product < ApplicationRecord
  belongs_to :shop

  has_many :customer_purchase_histories, dependent: :destroy
  has_many :thumbnails, as: :thumbnailable, dependent: :destroy
  has_many :product_sizes, dependent: :destroy
  has_many :sizes, through: :product_sizes
  has_many :product_colors, dependent: :destroy
  has_many :colors, through: :product_colors
end
