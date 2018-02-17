class EntertainmentsController < ApplicationController
  before_action :set_entertainment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /entertainment
  # GET /entertainment.json
  def index
    user_subscribed
    @entertainments = Entertainment.search(params[:term]).order(created_at: :desc)
    if @entertainments.class == Array
    # @entertainment = Kaminari.paginate_array(@entertainment).page(params[:page])
    @entertainments = Entertainment.order(created_at: :desc).page params[:page]

    else
    # @entertainment = Entertainment.order(created_at: :desc).page params[:page]
    @entertainments = Kaminari.paginate_array(@entertainments).page(params[:page]).per(12) 
    end
  end

  # GET /entertainment/1
  # GET /entertainment/1.json
  def show
    is_admin?
  end

  # GET /entertainment/new
  def new
    is_admin?
    @entertainment = Entertainment.new
  end

  # GET /entertainment/1/edit
  def edit
    is_admin?
  end

  # POST /entertainment
  # POST /entertainment.json
  def create
    @entertainment = Entertainment.new(entertainment_params)

    respond_to do |format|
      if @entertainment.save
        format.html { redirect_to @entertainment, notice: 'Entertainment was successfully created.' }
        format.json { render :show, status: :created, location: @entertainment }
      else
        format.html { render :new }
        format.json { render json: @entertainment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entertainment/1
  # PATCH/PUT /entertainment/1.json
  def update
    is_admin?
    respond_to do |format|
      if @entertainment.update(entertainment_params)
        format.html { redirect_to @entertainment, notice: 'Entertainment was successfully updated.' }
        format.json { render :show, status: :ok, location: @entertainment }
      else
        format.html { render :edit }
        format.json { render json: @entertainment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entertainment/1
  # DELETE /entertainment/1.json
  def destroy
    is_admin?
    @entertainment.destroy
    respond_to do |format|
      format.html { redirect_to entertainment_index_url, notice: 'Entertainment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entertainment
      @entertainment = Entertainment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entertainment_params
      params.require(:entertainment).permit(
      :title, 
      :source, 
      :title_url, 
      :image_url
      )
    end
end
