# frozen_string_literal: true

module Items
  class CreateOperation < ::ApplicationOperation
    def call(params, current_user)
      @current_user = current_user
      @attrs = yield Validate(Contracts::Create, params.merge(user_id: current_user.id))

      @item = create_item
      update_wishlist
      parse_external_data if @item.url.present?

      Success(@item)
    end

    private

    def create_item
      Item.create(@attrs.except(:user_id))
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
