# frozen_string_literal: true
# frozen_string_literal: true

require 'action_dispatch/middleware/static'

ActionDispatch::FileHandler.class_eval do
  private

    def gzip_file_path(path)
      return false if ['image/png', 'image/jpeg', 'image/gif'].include? content_type(path)
      gzip_path = "#{path}.gz"
      if File.exist?(File.join(@root, ::Rack::Utils.unescape_path(gzip_path)))
        gzip_path
      else
        false
      end
    end
end
