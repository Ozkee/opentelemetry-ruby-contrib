# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require 'test_helper'

describe OpenTelemetry::Instrumentation::Hanami do
  include Rack::Test::Methods

  let(:instrumentation) { OpenTelemetry::Instrumentation::Hanami::Instrumentation.instance }
  let(:exporter) { EXPORTER }
  let(:hanami_app) { DEFAULT_HANAMI_APP }

  before do
    instrumentation.install
    # binding.pry
    exporter.reset
  end

  describe 'tracing' do
    it 'before request' do
      _(exporter.finished_spans.size).must_equal 0
    end

    it 'after request' do
      response = get('/ok')

      _(response.body).must_equal 'actually ok'
      _(response.status).must_equal 200

      _(exporter.finished_spans.size).must_equal 1
    end

    it 'records attributes' do
      get '/ok'

      _(exporter.finished_spans.first.attributes).must_equal(
        'http.host' => 'example.org',
        'http.method' => 'GET',
        # 'http.route' => '/ok',
        'http.scheme' => 'http',
        'http.status_code' => 200,
        'http.target' => '/ok'
      )
    end
  end

  def app
    hanami_app
  end
end
