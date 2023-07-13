# frozen_string_literal: true

module Profiles
  module Contracts
    class UpdateAvatar < ::ApplicationContract
      params do
        required(:avatar)
      end

      rule(:avatar) do
        if value.present?
          key.failure('must be a JPEG or PNG image') unless value.content_type.in?(%w[image/jpeg image/png])

          key.failure('size must be less than or equal to 5MB') unless value.size <= 5.megabytes
        end
      end
    end
  end
end
