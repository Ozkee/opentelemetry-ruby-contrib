# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require 'opentelemetry'

module OpenTelemetry
  module Instrumentation
    module Hanami
      # The Instrumentation class contains logic to detect and install the Rails
      # instrumentation
      class Instrumentation < OpenTelemetry::Instrumentation::Base
        MINIMUM_VERSION = Gem::Version.new('2.0.0.beta3')

        install do |_|
          install_rack_telemetry
          require_dependencies
          add_middlewares
        end
        present { defined?(::Hanami) }
        compatible { gem_version >= MINIMUM_VERSION }

        private

        def install_rack_telemetry
          OpenTelemetry::Instrumentation::Rack::Instrumentation.instance.install({})
        end

        def require_dependencies
          require_relative 'middlewares/tracer_middleware'
        end

        def add_middlewares
          ::Hanami.app.config.middleware.use OpenTelemetry::Instrumentation::Rack::Middlewares::TracerMiddleware
          ::Hanami.app.config.middleware.use Middlewares::TracerMiddleware
        end

        def gem_version
          Gem::Version.new(::Hanami::VERSION)
        end
      end
    end
  end
end
