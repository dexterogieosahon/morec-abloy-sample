# frozen_string_literal: true

require './app/open_api/api_definitions/main'

module Api
  module Controllers
    # Application main handler.
    class Main < Base

      include Swagger::Blocks

      # GET - /
      get '/' do
        halt 200, ok(message: 'Movie API')
      end

      # GET - /recommendations
      get '/recommendations' do
        result = ::Usecase::Movie.recommendations(params)
        halt 200, ok(result[:data])
      end

      # GET - /healthz
      get '/healthz' do
        content_type 'text/plain'
        halt 200, 'OK'
      end

      # GET - /version
      get '/version' do
        halt 200, version_info
      end

      # GET - /swagger.json
      get '/swagger.json' do
        halt 200, api_definition
      end

      # api definition
      def api_definition
        ::Aux.h2json(::OpenApi::ApiDefinitions::Main.docs)
      end

    end
  end
end
