# frozen_string_literal: true

require './server'

require '../example/config/app'
require '../example/config/routes'
require '../example/config/settings'

Hanami.prepare

ENV['OTEL_TRACES_EXPORTER'] = 'console'
OpenTelemetry::SDK.configure do |c|
  c.use 'OpenTelemetry::Instrumentation::Hanami'
end

run Hanami.app
