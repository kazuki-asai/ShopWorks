class CreateProcessSteps < ActiveRecord::Migration[8.1]
  def change
    create_table :process_steps do |t|
      t.string :name
      t.integer :position
      t.references :shop, null: true, foreign_key: true

      t.timestamps
    end
  end
end
