# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

class ApplicationOperation
  def self.inherited(subclass)
    super
    subclass.include Dry::Monads[:result, :try]
    subclass.include Dry::Monads::Do.for(:call)
  end

  def call(_params)
    throw NotImplementedError.new "Method '#call' not implemented in #{self.class}"
  end

  attr_reader :model

  private

  #
  # Macroses
  # Reusable methods for most often repeated steps in operations
  # Must return Result Monad (Success or Failure)
  #

  # Validates specified dry-validation contract
  def validate(contract_class, params, context = {})
    attrs = if params.class.respond_to?(:dry_initializer)
              params.class.dry_initializer.attributes(params)
            else
              params.to_enum.to_h
            end

    result = contract_class.new.call(attrs, context)

    if result.success?
      Success(result.to_h)
    else
      Failure([:not_valid, result])
    end
  end
end
