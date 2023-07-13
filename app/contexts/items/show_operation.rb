# frozen_string_literal: true

module Items
  class ShowOperation < ::ApplicationOperation
    def call(params, current_user)
      @attrs = yield validate(Contracts::Show, params.merge(user_id: current_user&.id))

      item = Item.find(@attrs[:id])

      Success(item)
    end
  end
end
