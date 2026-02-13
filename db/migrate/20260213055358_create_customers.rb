class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :last_name_kana
      t.string :first_name_kana
      t.string :email
      t.string :phone
      t.string :address
      t.string :password_digest
      t.integer :gender
      t.date :birthday
      t.references :shop, null: true, foreign_key: true

      t.timestamps
    end
  end
end
