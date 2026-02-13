class ProcessStep < ApplicationRecord
  default_scope { order(:position) }
  belongs_to :shop
end
