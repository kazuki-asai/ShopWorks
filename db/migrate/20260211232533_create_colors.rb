class CreateColors < ActiveRecord::Migration[8.1]
  def change
    create_table :colors do |t|
      t.string :name
      t.integer :position, default: 0, null: false
      t.references :shop, null: true, foreign_key: true

      t.timestamps
    end
  end
end
