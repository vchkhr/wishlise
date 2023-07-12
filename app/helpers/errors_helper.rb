# frozen_string_literal: true

module ErrorsHelper
  class SimpleFormError
    def call(result)
      result.failure[1].errors.to_h
    end
  end

  class AlertError
    def call(result)
      error_text = result.failure[1].errors.to_h
                         .map { |path, text| "#{path.to_s.titleize} #{text.join(', ')}" }
                         .join('. ')
      "#{error_text}."
    end
  end
end
