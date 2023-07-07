# frozen_string_literal: true

module Items
  class ShowOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield Validate(Contracts::Show, params.merge(user_id: current_user&.id))

      @item = find_item

      Success(@item)
    end

    private
    def find_item
      Item.find(@attrs[:id])
    end
  end
end
