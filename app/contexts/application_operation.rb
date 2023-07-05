# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

class ApplicationOperation
  def self.inherited(subclass)
    subclass.include Dry::Monads[:result, :try]
    subclass.include Dry::Monads::Do.for(:call)
  end

  def call(params)
    throw NotImplementedError.new "Method '#call' not implemented in #{self.class}"
  end

  attr_reader :model

  private

  #
  # Macroses
  # Reusable methods for most often repeated steps in operations
  # Must return Result Monad (Success or Failure)
  #

  # Finds ActiveRecord model by specified conditions
  def ModelFindBy(ar_class, conditions)
    entity = ar_class.find_by(conditions)
    if entity.present?
      @model = entity
      Success(entity)
    else
      Failure([:not_found, "Not found"])
    end
  end

  # Creates new instance of the model
  def ModelNew(ar_class, attributes)
    entity = ar_class.new(attributes)
    @model = entity
    Success(entity)
  end

  # Validates specified dry-validation contract
  def Validate(contract_class, params, context = {})
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

  def Save(model, attributes = {})
    model.attributes = attributes if attributes.present?
    if model.save
      Success(model)
    else
      Failure([:not_saved, model.errors])
    end
  end

  def ValidateUnique(model_class, attr, attributes, except_object = nil)
    duplicate = model_class.find_by({attr => attributes[attr]})
    if duplicate.present? && duplicate.id != except_object.id
      Failure("#{model_class.to_s.titleize} #{attr} should be unique")
    else
      Success()
    end
  end
end
