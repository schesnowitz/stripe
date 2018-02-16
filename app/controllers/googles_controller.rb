class GooglesController < ApplicationController
  before_action :set_google, only: [:show, :edit, :update, :destroy]

  # GET /google
  # GET /google.json
  def index
    @googles = Google.search(params[:term]).order(created_at: :desc)
    if @googles.class == Array
    # @google = Kaminari.paginate_array(@google).page(params[:page])
    @googles = Google.order(created_at: :desc).page params[:page]

    else
    # @google = Google.order(created_at: :desc).page params[:page]
    @googles = Kaminari.paginate_array(@googles).page(params[:page]).per(12) 
    end
  end

  # GET /google/1
  # GET /google/1.json
  def show
    is_admin?
  end

  # GET /google/new
  def new
    is_admin?
    @google = Google.new
  end

  # GET /google/1/edit
  def edit
    is_admin?
  end

  # POST /google
  # POST /google.json
  def create
    @google = Google.new(google_params)

    respond_to do |format|
      if @google.save
        format.html { redirect_to @google, notice: 'Google was successfully created.' }
        format.json { render :show, status: :created, location: @google }
      else
        format.html { render :new }
        format.json { render json: @google.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /google/1
  # PATCH/PUT /google/1.json
  def update
    is_admin?
    respond_to do |format|
      if @google.update(google_params)
        format.html { redirect_to @google, notice: 'Google was successfully updated.' }
        format.json { render :show, status: :ok, location: @google }
      else
        format.html { render :edit }
        format.json { render json: @google.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /google/1
  # DELETE /google/1.json
  def destroy
    is_admin?
    @google.destroy
    respond_to do |format|
      format.html { redirect_to google_index_url, notice: 'Google was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_google
      @google = Google.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def google_params
      params.require(:google).permit(
      :title, 
      :source, 
      :title_url, 
      :image_url
      )
    end
end
