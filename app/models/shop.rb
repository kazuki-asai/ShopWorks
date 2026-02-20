class Shop < ApplicationRecord
  before_create :generate_code, unless: :code?

  validates :code, uniqueness: true, allow_nil: true

  has_many :users, dependent: :nullify
  has_many :products, dependent: :destroy
  has_many :sizes, dependent: :destroy
  has_many :colors, dependent: :destroy
  has_many :process_steps, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :customer_purchase_histories, dependent: :destroy

  private

  def generate_code
    loop do
      self.code = SecureRandom.alphanumeric(12)
      break unless Shop.exists?(code: code)
    end
  end
end
