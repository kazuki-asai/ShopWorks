class CreateThumbnails < ActiveRecord::Migration[8.1]
  def change
    create_table :thumbnails do |t|
      t.references :thumbnailable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
