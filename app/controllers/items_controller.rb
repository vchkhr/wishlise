# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :complete_registration!
  before_action :set_item, only: %i[edit update destroy update_image destroy_image]

  def show
    result = Items::ShowOperation.new.call(params, current_user)

    if result.success?
      @item = result.value!
    else
      redirect_to root_path, notice: ErrorsHelper::AlertError.new.call(result)
    end
  end

  def new
    redirect_to new_wishlist_path if current_user.wishlists.empty?
    @item = new_item(params)
  end

  def edit; end

  def create
    result = Items::CreateOperation.new.call(item_params, current_user)

    if result.success?
      redirect_to wishlist_path(result.value!.wishlist.id), notice: 'Item was successfully added.'
    else
      render turbo_stream: turbo_stream.replace(:item_form_frame, partial: 'items/form', locals: { item: new_item(item_params), errors: ErrorsHelper::SimpleFormError.new.call(result) })
    end
  end

  def update
    result = Items::UpdateOperation.new.call(item_params.merge(id: params[:id]), current_user)

    if result.success?
      redirect_to item_path(@item), notice: 'Item was successfully updated.'
    else
      @item.assign_attributes(item_params)

      render turbo_stream: turbo_stream.replace(:item_form_frame, partial: 'items/form', locals: { item: @item, errors: ErrorsHelper::SimpleFormError.new.call(result) })
    end
  end

  def destroy
    wishlist = @item.wishlist
    result = Items::DestroyOperation.new.call({ id: params[:id] }, current_user)

    if result.success?
      redirect_to wishlist_path(wishlist), notice: 'Item was successfully deleted.'
    else
      redirect_to wishlist_path(wishlist), notice: ErrorsHelper::AlertError.new.call(result)
    end
  end

  def update_image
    result = Items::UpdateImageOperation.new.call(image_params.merge(id: params[:id]), current_user)

    if result.success?
      render turbo_stream: turbo_stream.replace("item_#{@item.id}", partial: 'items/show', locals: { item: @item, result: 'Image was updated.' })
    else
      render turbo_stream: turbo_stream.replace("item_#{@item.id}", partial: 'items/show', locals: { item: @item, result: ErrorsHelper::AlertError.new.call(result) })
    end
  end

  def destroy_image
    result = Items::UpdateImageOperation.new.call({ id: params[:id], image: nil }, current_user)

    if result.success?
      render turbo_stream: turbo_stream.replace("item_#{@item.id}", partial: 'items/show', locals: { item: @item, result: 'Image was removed.' })
    else
      render turbo_stream: turbo_stream.replace("item_#{@item.id}", partial: 'items/show', locals: { item: @item, result: ErrorsHelper::AlertError.new.call(result) })
    end
  end

  private

  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def new_item(params = {})
    params = params.permit(:wishlist_id, :title, :url, :price, :description) unless params.empty?
    current_user.items.new(params)
  end

  def item_params
    params[:item].permit(:wishlist_id, :title, :url, :price, :description)
  end

  def image_params
    params[:item].permit(:image)
  end
end
