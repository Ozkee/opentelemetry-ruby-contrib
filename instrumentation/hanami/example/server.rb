#!/usr/bin/env ruby

# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require 'bundler/inline'

gemfile(true) do
  source 'https://rubygems.org'

  # gem 'hanami', '2.0.0.rc1'
  # gem 'hanami-router', '2.0.0.rc1'
  # gem 'hanami-controller', '2.0.0.rc1'

  gem 'hanami', '2.0.0.beta3'
  gem 'hanami-router', '2.0.0.beta2'
  gem 'hanami-controller', '2.0.0.beta1'
  gem 'hanami-utils', '2.0.0.beta1'

  gem 'dry-system', '0.25.0'

  gem 'puma'
  gem 'rack', '2.2.4'

  gem 'opentelemetry-sdk'
  gem 'opentelemetry-instrumentation-hanami', path: '../../hanami'
end

# To run this example run the `rackup` command
# Example: rackup config.ru
# Navigate to http://localhost:9292/
# Spans for the requests will appear in the console
