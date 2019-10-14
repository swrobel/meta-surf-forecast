# frozen_string_literal: true

class UpdateBatch < ApplicationRecord
  attr_accessor :start_time

  after_initialize :set_defaults

  has_many :requests, class_name: 'ApiRequest', dependent: :nullify

  def set_duration!
    update!(duration: Time.current - start_time)
  end

private

  def set_defaults
    self.concurrency ||= ENV.fetch('API_CONCURRENCY', rand(10..30))
    self.start_time ||= Time.current
  end
end
