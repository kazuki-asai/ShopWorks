class Shop < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :products, dependent: :destroy
  has_many :sizes, dependent: :destroy
  has_many :colors, dependent: :destroy
  has_many :process_steps, dependent: :destroy
  has_many :customers, dependent: :destroy
end
