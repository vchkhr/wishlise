# frozen_string_literal: true

module Items
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield Validate(Contracts::Update, params.merge(user_id: current_user.id))

      @item = find_item
      update_item
      update_wishlist
      parse_external_data if @item.url.present?

      Success(@item)
    end

    private

    def find_item
      Item.find(@attrs[:id])
    end

    def update_item
      @item.update(@attrs.except(:user_id))
    end

    def update_wishlist
      @item.wishlist.update(updated_at: Time.zone.now)
    end

    def parse_external_data
      @item.update(is_being_parsed: true)
      ParseExternalDataJob.perform_later(@item)
    end
  end
end
