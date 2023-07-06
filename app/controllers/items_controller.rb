class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :complete_registration!
  before_action :set_item, only: %i[ edit update ]

  # GET /items/1 or /items/1.json
  def show
  end

  def new
    @item = new_item(params)
  end

  # GET /items/1/edit
  def edit
  end

  def create
    result = Items::CreateOperation.new.call(item_params, current_user)

    if result.success?
      redirect_to wishlist_path(result.value!.wishlist.id), notice: "Item was successfully added."
    else
      render turbo_stream: turbo_stream.replace(:item_form_frame, partial: "items/form", locals: { item: new_item(item_params), errors: result.failure[1].errors.to_h })
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
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
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def new_item(params={})
    params = params.permit(:wishlist_id, :title, :url, :price, :description) unless params.empty?
    current_user.items.new(params)
  end

  def item_params
    params[:item].permit(:wishlist_id, :title, :url, :price, :description)
  end
end
