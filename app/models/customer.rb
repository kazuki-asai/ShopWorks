class Customer < ApplicationRecord
  belongs_to :shop

  has_many :customer_purchase_histories, dependent: :destroy

  attribute :gender, :integer
  enum :gender, male: 0, female: 1, other: 2

  has_secure_password validations: false

  scope :active, -> { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end
end
