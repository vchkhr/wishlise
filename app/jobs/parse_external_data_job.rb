# frozen_string_literal: true

class ParseExternalDataJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Items::ParseExternalDataOperation.new.call({ id: args[0].id })
  end
end
