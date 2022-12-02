# frozen_string_literal: true

require './server'

require '../test/test_helpers/config/app'
require '../test/test_helpers/config/routes'
require '../test/test_helpers/config/settings'

Hanami.prepare

ENV['OTEL_TRACES_EXPORTER'] = 'console'
OpenTelemetry::SDK.configure do |c|
  c.use 'OpenTelemetry::Instrumentation::Hanami'
end

run Hanami.app
