class TecsController < ApplicationController
  before_action :set_tec, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /tec
  # GET /tec.json
  def index
    user_subscribed
    @tecs = Tec.search(params[:term]).order(created_at: :desc)
    if @tecs.class == Array
    # @tec = Kaminari.paginate_array(@tec).page(params[:page])
    @tecs = Tec.order(created_at: :desc).page params[:page]

    else
    # @tec = Tec.order(created_at: :desc).page params[:page]
    @tecs = Kaminari.paginate_array(@tecs).page(params[:page]).per(12) 
    end
  end

  # GET /tec/1
  # GET /tec/1.json
  def show
    is_admin?
  end

  # GET /tec/new
  def new
    is_admin?
    @tec = Tec.new
  end

  # GET /tec/1/edit
  def edit
    is_admin?
  end

  # POST /tec
  # POST /tec.json
  def create
    @tec = Tec.new(tec_params)

    respond_to do |format|
      if @tec.save
        format.html { redirect_to @tec, notice: 'Tec was successfully created.' }
        format.json { render :show, status: :created, location: @tec }
      else
        format.html { render :new }
        format.json { render json: @tec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tec/1
  # PATCH/PUT /tec/1.json
  def update
    is_admin?
    respond_to do |format|
      if @tec.update(tec_params)
        format.html { redirect_to @tec, notice: 'Tec was successfully updated.' }
        format.json { render :show, status: :ok, location: @tec }
      else
        format.html { render :edit }
        format.json { render json: @tec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tec/1
  # DELETE /tec/1.json
  def destroy
    is_admin?
    @tec.destroy
    respond_to do |format|
      format.html { redirect_to tec_index_url, notice: 'Tec was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tec
      @tec = Tec.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tec_params
      params.require(:tec).permit(
      :title, 
      :source, 
      :title_url, 
      :image_url
      )
    end
end
