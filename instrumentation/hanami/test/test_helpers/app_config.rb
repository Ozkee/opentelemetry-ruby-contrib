# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require_relative 'config/app'
require_relative 'config/routes'
require_relative 'config/settings'

module AppConfig
  extend self

  def initialize_app
    new_app = Bookshelf::Application.new
    new_app.setup

    Rack::Builder.new do
      run new_app
    end.to_app

    new_app
  end
end
