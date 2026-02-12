class CreateSizes < ActiveRecord::Migration[8.1]
  def change
    create_table :sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
