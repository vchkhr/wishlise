class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :complete_registration!
  before_action :set_wishlist, only: %i[ show edit update destroy ]

  def index
    @wishlists = current_user.wishlists
    redirect_to new_wishlist_path if @wishlists.empty?
  end

  def show
  end

  def new
    @wishlist = new_wishlist
  end

  def edit
  end

  def create
    result = Wishlists::CreateOperation.new.call(wishlist_params, current_user)

    if result.success?
      redirect_to wishlist_path(result.value!.id), notice: "Wishlist was successfully created."
    else
      render turbo_stream: turbo_stream.replace(:wishlist_form_frame, partial: "wishlists/form", locals: { wishlist: new_wishlist(wishlist_params), errors: result.failure[1].errors.to_h })
    end
  end

  def update
    respond_to do |format|
      if @wishlist.update(wishlist_params)
        format.html { redirect_to wishlist_url(@wishlist), notice: "Wishlist was successfully updated." }
        format.json { render :show, status: :ok, location: @wishlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlists/1 or /wishlists/1.json
  def destroy
    @wishlist.destroy

    respond_to do |format|
      format.html { redirect_to wishlists_url, notice: "Wishlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def new_wishlist(params={})
    current_user.wishlists.new(params)
  end

  def set_wishlist
    @wishlist = Wishlist.find(params[:id])
  end

  def wishlist_params
    params.require(:wishlist).permit(:title, :publicity)
  end
end
