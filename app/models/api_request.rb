# frozen_string_literal: true

class ApiRequest < ApplicationRecord
  attr_accessor :hydra, :options, :typhoeus_opts

  after_initialize :set_defaults

  belongs_to :batch, class_name: 'UpdateBatch', counter_cache: :requests_count, optional: true
  belongs_to :requestable, polymorphic: true

  include ApiRequests::Msw
  include ApiRequests::Spitcast
  include ApiRequests::SurflineV1
  include ApiRequests::SurflineV2

  def get(retries: 0)
    self.request ||= requestable.send(service_url_method)
    call = Typhoeus::Request.new(request, typhoeus_opts.merge(followlocation: true))

    call.on_complete do |response|
      if response.success?
        safely do # Handle malformed JSON, which raises
          data = JSON.parse(response.body)
          self.attributes = { response: data, success: true, response_time: response.total_time }
          save!
          send(service_parse_method)
        end
      else
        self.attributes = { response: { message: response.status_message, headers: response.headers, status: response.code }, success: false, response_time: response.total_time }
        save!
        SurflineV2.expire_access_token if service == 'SurflineV2' && response.code == 401 # Unauthorized
        get(retries: retries + 1) unless retries >= API_RETRIES
      end
    end

    if hydra.present?
      hydra.queue(call)
    else
      call.run
    end
  end

  def service_class
    service.constantize
  end

  def service_url_method
    "#{service.underscore}_api_url"
  end

  def service_parse_method
    "parse_#{service.underscore}"
  end

private

  def set_defaults
    self.options ||= {}
    self.typhoeus_opts ||= {}
  end
end
