# frozen_string_literal: true

module Items
  class DestroyOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield Validate(Contracts::Destroy, params.merge(user_id: current_user.id))

      @item = find_item
      @item = destroy_item

      Success(@item)
    end

    private
    def find_item
      Item.find(@attrs[:id])
    end

    def destroy_item
      @item.destroy
    end
  end
end
