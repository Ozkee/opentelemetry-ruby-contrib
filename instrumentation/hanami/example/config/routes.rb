# frozen_string_literal: true

require 'hanami/routes'

module Bookshelf
  # rubocop:disable Style/Documentation
  class Routes < Hanami::Routes
    root { 'Hello from Hanami' }

    get '/hanami', to: ->(_env) { [200, {}, ['Hello from Hanami!']] }
  end
  # rubocop:enable Style/Documentation
end
