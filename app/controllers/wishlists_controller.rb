class WishlistsController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :complete_registration!
  before_action :set_wishlist, only: %i[ edit update ]

  def index
    result = Wishlists::IndexOperation.new.call(params, current_user)

    if result.success?
      @wishlists = result.value!
      redirect_to new_wishlist_path if @wishlists.empty?
    else
      redirect_to root_path, notice: result.failure[1].errors.messages.map!(&:text).join(". ")
    end
  end

  def show
    result = Wishlists::ShowOperation.new.call(params, current_user)

    if result.success?
      @wishlist = result.value!
    else
      redirect_to root_path, notice: result.failure[1].errors.messages.map!(&:text).join(". ")
    end
  end

  def new
    @wishlist = new_wishlist
  end

  def edit
  end

  def create
    result = Wishlists::CreateOperation.new.call(wishlist_params, current_user)

    if result.success?
      redirect_to wishlist_path(result.value!), notice: "Wishlist was successfully created."
    else
      render turbo_stream: turbo_stream.replace(:wishlist_form_frame, partial: "wishlists/form", locals: { wishlist: new_wishlist(wishlist_params), errors: result.failure[1].errors.to_h })
    end
  end

  def update
    result = Wishlists::UpdateOperation.new.call(wishlist_params.merge(id: params[:id]), current_user)

    if result.success?
      redirect_to wishlist_path(@wishlist), notice: "Wishlist was successfully updated."
    else
      @wishlist.assign_attributes(wishlist_params)

      render turbo_stream: turbo_stream.replace(:wishlist_form_frame, partial: "wishlists/form", locals: { wishlist: @wishlist, errors: result.failure[1].errors.to_h })
    end
  end

  def destroy
    result = Wishlists::DestroyOperation.new.call({id: params[:id]}, current_user)

    if result.success?
      redirect_to wishlists_path, notice: "Wishlist was successfully deleted."
    else
      redirect_to wishlists_path, notice: result.failure[1].errors.messages.map!(&:text).join(". ")
    end
  end

  private
  def set_wishlist
    @wishlist = Wishlist.find_by(id: params[:id])
  end

  def new_wishlist(params={})
    params = params.permit(:title, :publicity) unless params.empty?
    current_user.wishlists.new(params)
  end

  def wishlist_params
    params[:wishlist].permit(:title, :publicity)
  end
end
