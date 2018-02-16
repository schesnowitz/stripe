json.extract! app_setting, :id, :app_name, :tab_name, :email, :street, :city, :state, :postal_code, :created_at, :updated_at
json.url app_setting_url(app_setting, format: :json)
