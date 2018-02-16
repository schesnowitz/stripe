class CreateTecs < ActiveRecord::Migration[5.2]
  def change
    create_table :tecs do |t|
      t.string :title
      t.string :source
      t.string :title_url
      t.string :image_url

      t.timestamps
    end
  end
end
