class Thumbnail < ApplicationRecord
  belongs_to :thumbnailable, polymorphic: true

  has_one_attached :image
end
