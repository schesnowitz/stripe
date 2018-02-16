class AppSettingsController < ApplicationController
  before_action :set_app_setting, only: [:show, :edit, :update, :destroy]

  # GET /app_settings
  # GET /app_settings.json
  def index
    is_admin?
    @app_settings = AppSetting.all
  end

  # GET /app_settings/1
  # GET /app_settings/1.json
  def show

  end

  # GET /app_settings/new
  def new
    is_admin?
    @app_setting = AppSetting.new
  end

  # GET /app_settings/1/edit
  def edit
  end

  # POST /app_settings
  # POST /app_settings.json
  def create
    is_admin?
    @app_setting = AppSetting.new(app_setting_params)

    respond_to do |format|
      if @app_setting.save
        format.html { redirect_to @app_setting, notice: 'App setting was successfully created.' }
        format.json { render :show, status: :created, location: @app_setting }
      else
        format.html { render :new }
        format.json { render json: @app_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_settings/1
  # PATCH/PUT /app_settings/1.json
  def update
    respond_to do |format|
      if @app_setting.update(app_setting_params)
        format.html { redirect_to @app_setting, notice: 'App setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_setting }
      else
        flash[:danger] = "#{@app_setting.errors.full_messages.to_sentence}"
        format.json { render json: @app_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_settings/1
  # DELETE /app_settings/1.json
  def destroy
    is_admin?
    @app_setting.destroy
    respond_to do |format|
      format.html { redirect_to app_settings_url, notice: 'App setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_theme

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_setting
      @app_setting = AppSetting.find(1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_setting_params
      params.require(:app_setting).permit(:app_name, :tab_name, :email, :street, :city, :state, :postal_code)
    end
end
