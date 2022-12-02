# frozen_string_literal: true

require 'hanami/routes'

module Bookshelf
  class Routes < Hanami::Routes
    root { 'Hello from Hanami' }

    get '/ok', to: ->(_env) { [200, {}, ['actually ok']] }
  end
end
