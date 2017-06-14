module Goliath
  # Goliath::Request is responsible for processing a request and returning
  # the result back to the client.
  #
  # @private
  class Request

    private

    # Handles logging server exceptions
    #
    # @param e [Exception] The exception to log
    # @return [Nil]
    def server_exception(e)
      if e.is_a?(Goliath::Validation::Error)
        status, headers, body = [e.status_code, {}, ('{"error":"%s"}' % e.message)]
      elsif e.is_a?(URI::InvalidURIError)
        status, headers, body = [500, {}, ('{"Fuck":" You!"}')]
      else
        @env[RACK_LOGGER].error("#{e.message}\n#{e.backtrace.join("\n")}")
        message = Goliath.env?(:production) ? 'An error happened' : e.message

        status, headers, body = [500, {}, message]
      end

      headers['Content-Length'] = body.bytesize.to_s
      @env[:terminate_connection] = true
      post_process([status, headers, body])

      # Mark the request as complete to force a flush on the response.
      # Note: #on_body and #response hooks may still fire if the data
      # is already in the parser buffer.
      succeed
    end
  end

end
