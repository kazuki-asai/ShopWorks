class Color < ApplicationRecord
  default_scope { order(:position) }

  belongs_to :shop
  has_many :product_colors, dependent: :destroy
  has_many :products, through: :product_colors
end
