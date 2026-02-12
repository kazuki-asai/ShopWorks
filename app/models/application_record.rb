class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :by_current_shop, -> {
    if Current.user && !Current.user.admin?
      where(shop_id: Current.user.shop_id)
    else
      all
    end
  }
end
