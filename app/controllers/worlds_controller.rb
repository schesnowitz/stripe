class WorldsController < ApplicationController
  before_action :set_world, only: [:show, :edit, :update, :destroy]

  # GET /world
  # GET /world.json
  def index
    @worlds = World.search(params[:term]).order(created_at: :desc)
    if @worlds.class == Array
    # @world = Kaminari.paginate_array(@world).page(params[:page])
    @worlds = World.order(created_at: :desc).page params[:page]

    else
    # @world = World.order(created_at: :desc).page params[:page]
    @worlds = Kaminari.paginate_array(@worlds).page(params[:page]).per(12) 
    end


    Pusher.trigger('my-channel', 'my-event', {
      message: 'hello world'
    })
  end

  # GET /world/1
  # GET /world/1.json
  def show
    # is_admin?
    @comment = Comment.new 
  end

  # GET /world/new
  def new
    is_admin?
    @world = World.new
  end

  # GET /world/1/edit
  def edit
    is_admin?
  end

  # POST /world
  # POST /world.json
  def create
    @world = World.new(world_params)

    respond_to do |format|
      if @world.save
        format.html { redirect_to @world, notice: 'World was successfully created.' }
        format.json { render :show, status: :created, location: @world }
      else
        format.html { render :new }
        format.json { render json: @world.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /world/1
  # PATCH/PUT /world/1.json
  def update
    is_admin?
    respond_to do |format|
      if @world.update(world_params)
        format.html { redirect_to @world, notice: 'World was successfully updated.' }
        format.json { render :show, status: :ok, location: @world }
      else
        format.html { render :edit }
        format.json { render json: @world.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /world/1
  # DELETE /world/1.json
  def destroy
    is_admin?
    @world.destroy
    respond_to do |format|
      format.html { redirect_to world_index_url, notice: 'World was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_world
      @world = World.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def world_params
      params.require(:world).permit(
      :title, 
      :source, 
      :title_url, 
      :image_url
      )
    end
end
