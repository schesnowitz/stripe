class CreateAppSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :app_settings do |t|
      t.string :app_name
      t.string :tab_name
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code

      t.timestamps
    end
  end
end
