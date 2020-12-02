class ApiRequest < ApplicationRecord
  attr_accessor :hydra, :options, :typhoeus_opts

  after_initialize :set_defaults

  belongs_to :batch, class_name: 'UpdateBatch', optional: true
  belongs_to :requestable, polymorphic: true

  include ApiRequests::BuoyReport
  include ApiRequests::Msw
  include ApiRequests::SpitcastV2
  include ApiRequests::SurflineV1
  include ApiRequests::SurflineV2

  def get(retries: 0)
    save! && return if retries >= API_RETRIES

    self.request ||= requestable.send(service_url_method, **options)
    call = Typhoeus::Request.new(request, typhoeus_opts.merge(accept_encoding: 'gzip', followlocation: true, http_version: :httpv2_0)) # rubocop:disable Naming/VariableNumber

    call.on_complete do |response|
      if response.success?
        # Remove invalid UTF-8 chars from response, ex: Surfline v1 'S�o Jo�o'
        response.body.delete!("^\u{0000}-\u{007F}")
        self.attributes = { response: service_class.parse(response.body), success: true, response_time: response.total_time, retries: retries }
        save!
        send(service_parse_method)
      else
        self.attributes = { response: { message: response.status_message, headers: response.headers, status: response.code }, success: false, response_time: response.total_time, retries: retries }
        SurflineV2.expire_access_token if service == 'SurflineV2' && response.code == 401 # Unauthorized
        get(retries: retries + 1)
      end
    end

    if hydra.present?
      hydra.queue(call)
    else
      call.run
    end
  rescue StandardError => e
    Safely.report_exception(e)
    self.retries = retries
    self.success = false
    self.response ||= e.as_json
    get(retries: retries + 1)
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
