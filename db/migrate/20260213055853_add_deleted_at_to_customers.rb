class AddDeletedAtToCustomers < ActiveRecord::Migration[8.1]
  def change
    add_column :customers, :deleted_at, :datetime
  end
end
