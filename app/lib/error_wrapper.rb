# frozen_string_literal: true
#
# adapt monad result for simple_form_for

class ErrorWrapper
  attr_accessor :errors

  def initialize(dry_monad_result, request_params, model: nil)
    @model = model
    @errors = dry_monad_result.failure.last.errors.to_h.deep_dup
    @errors.define_singleton_method(:full_messages_for) do |attr|
      self[attr]
    end
    input_params = dry_monad_result.failure.last.to_h
    input_params.reverse_merge(request_params.to_h.symbolize_keys).each do |attr_name, attr_val|
      singleton_class.class_eval { attr_accessor attr_name }
      attr_val = NestedErrorWrapper.new(@errors[attr_name] || {}, attr_val, request_params[attr_name], associated_model: model.try(attr_name.to_s.sub('_attributes', ''))) if attr_val.is_a?(Hash)
      send("#{attr_name}=", attr_val)
      # params for associated models
      if attr_name[/_attributes/]
        model_name = attr_name.to_s.sub('_attributes', '')
        singleton_class.class_eval { attr_accessor model_name }
        send("#{model_name}=", attr_val)
      end
    end
  end

  def method_missing(name)
    @model.send(name)
  end

  def persisted?
    @persisted
  end

  class NestedErrorWrapper
    attr_accessor :errors, :persisted

    def initialize(errors, values, request_params, associated_model: nil)
      @associated_model = associated_model
      @errors = errors
      @errors.define_singleton_method(:full_messages_for) do |attr|
        self[attr]
      end
      @persisted = values[:id].present?
      input_params = values
      input_params.reverse_merge(request_params.to_h.symbolize_keys).each do |attr_name, attr_val|
        singleton_class.class_eval { attr_accessor attr_name }
        send("#{attr_name}=", attr_val)
        if attr_val.is_a?(Hash)
          send("#{attr_name}=", NestedErrorWrapper.new(@errors[attr_name] || {}, attr_val, request_params[attr_name]))
        end
      end
    end

    def method_missing(name)
      @associated_model.send(name)
    end

    def persisted?
      @persisted
    end
  end
end
