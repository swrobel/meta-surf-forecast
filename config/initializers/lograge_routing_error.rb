# https://github.com/roidrage/lograge/issues/146#issuecomment-461632965

if defined?(Lograge) && Rails.application.config.lograge.enabled
  module ActionDispatch
    class DebugExceptions
      alias old_log_error log_error

      def log_error(request, wrapper)
        exception = wrapper.exception
        if exception.is_a?(ActionController::RoutingError)
          data = {
            method: request.env['REQUEST_METHOD'],
            path: request.env['REQUEST_PATH'],
            status: wrapper.status_code,
          }
          formatted_message = Lograge.formatter.call(data)
          logger(request).send(Lograge.log_level, formatted_message)
        elsif exception.is_a?(ActiveRecord::RecordNotFound)
          false
        else
          old_log_error request, wrapper
        end
      end
    end
  end
end
