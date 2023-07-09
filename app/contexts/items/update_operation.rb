# frozen_string_literal: true

module Items
  class UpdateOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield Validate(Contracts::Update, params.merge(user_id: current_user.id))

      @item = find_item
      @item = update_item

      Success(@item)
    end

    private
    def find_item
      Item.find(@attrs[:id])
    end

    def update_item
      @item.update(@attrs.except(:user_id))
    end
  end
end
