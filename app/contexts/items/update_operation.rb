# frozen_string_literal: true

module Items
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Update, params.merge(user_id: current_user.id))

      @item = Item.find(@attrs[:id])
      @item.update(@attrs.except(:user_id))
      @item.wishlist.update(updated_at: Time.zone.now)

      parse_external_data if @item.url.present?

      Success(@item)
    end

    private

    def parse_external_data
      @item.update(is_being_parsed: true)
      ParseExternalDataJob.perform_later(@item)
    end
  end
end
