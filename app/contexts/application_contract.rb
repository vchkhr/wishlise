# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  Dry::Validation.load_extensions(:monads)
end
