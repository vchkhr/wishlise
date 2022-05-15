class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :require_profile!, except: %i[ show ]
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.all
    authorize Item
  end

  # GET /items/1 or /items/1.json
  def show
    authorize @item.list, :show?
  end

  # GET /items/new
  def new
    @item = Item.new
    authorize @item
  end

  # GET /items/1/edit
  def edit
    authorize @item
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    authorize @item

    respond_to do |format|
      if @item.save
        format.html { redirect_to list_url(@item.list), notice: "We added this item to your wish list." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    authorize @item

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    authorize @item
    @item.destroy

    respond_to do |format|
      format.html { redirect_to list_url(@item.list), notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:list_id, :title, :description, :url, :image_url, :price)
    end
end
