class ListsController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :require_profile!, except: %i[ show ]
  before_action :set_list, only: %i[ show edit update destroy ]

  # GET /lists or /lists.json
  def index
    @lists = current_user.lists
  end

  # GET /lists/1 or /lists/1.json
  def show
    authorize @list
  end

  # GET /lists/new
  def new
    @list = List.new
    authorize @list
  end

  # GET /lists/1/edit
  def edit
    authorize @list
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)
    @list.user = current_user
    authorize @list
    
    respond_to do |format|
      if @list.save
        format.html { redirect_to root_url, notice: "We created your new wish list." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    authorize @list

    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list), notice: "We updated the information about this wish list." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    authorize @list
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "We deleted the wish list." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:title, :emoji_cd, :visibility_cd)
    end
end
