# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0
require 'opentelemetry-instrumentation-rack'

module OpenTelemetry
  module Instrumentation
    module Hanami
      module Middlewares
        # Middleware to trace Sinatra requests
        class TracerMiddleware
          def initialize(app)
            @app = app
          end

          def call(env)
            response = @app.call(env)
          ensure
            trace_response(env, response)
          end

          private

          def trace_response(env, response)
            span = OpenTelemetry::Instrumentation::Rack.current_span
            return unless span.recording?

            span.set_attribute('service.name', app_name)
            span.name = app_name

            # HERE COME THE HANAMI CUSTOM SPAN SETTINGS...

            # EXAMPLE FROM SINATRA INSTRUMENTATION
            # sinatra_response = ::Sinatra::Response.new([], response.first)
            # return unless sinatra_response.server_error?
            #
            # span.record_exception(env['sinatra.error'])
            # span.status = OpenTelemetry::Trace::Status.error
          end

          def app_name
            ::Hanami.app.name
          end
        end
      end
    end
  end
end
