class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :vote]
  before_action :authenticate_user!

  respond_to :js

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @world = World.find(params[:world_id])
    @comment = @world.comments.build
    # @comment.user = current_user

  end

  # GET /comments/1/edit
  def edit
    @comment.user = current_user
    @world = World.find(params[:world_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @world = World.find(params[:world_id]) 
    @comment = @world.comments.build(comment_params) 
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        Pusher.trigger('my-channel', 'my-event', {
          # text: @messages.each { |message| message.text }
          comment: @comment.comment, 
          user_email: @comment.user.email
        })
        format.json
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote

    if !current_user.liked? @comment
      @comment.liked_by current_user
    elsif current_user.liked? @comment
      @comment.unliked_by current_user
    end
      # @comment.vote_by current_user
      # # redirect_back(fallback_location: root_path) 
      # Pusher.trigger('my-channel2', 'my-event2', {
      #   up_vote: @comment.get_upvotes.size 
      # })

      # puts "Voted: #{@comment.get_upvotes.size}" 

  end 
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :comment, :world_id)
    end
end
