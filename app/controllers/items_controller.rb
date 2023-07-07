class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :complete_registration!
  before_action :set_item, only: %i[ edit update ]

  def show
    result = Items::ShowOperation.new.call(params, current_user)

    if result.success?
      @item = result.value!
    else
      redirect_to root_path, notice: result.failure[1].errors.messages.map!(&:text).join(". ")
    end
  end

  def new
    @item = new_item(params)
  end

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

  def update
    result = Items::UpdateOperation.new.call(item_params.merge(id: params[:id]), current_user)

    if result.success?
      redirect_to item_path(@item), notice: "Item was successfully updated."
    else
      @item.assign_attributes(item_params)

      render turbo_stream: turbo_stream.replace(:item_form_frame, partial: "item/form", locals: { item: @item, errors: result.failure[1].errors.to_h })
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
