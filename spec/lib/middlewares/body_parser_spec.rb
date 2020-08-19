# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BodyParser do
  let(:data) { ::Aux.h2json(data: { message: 'BodyParser' }) }
  let(:request_headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:iapp) do
    ->(_env) { [200, { 'Content-Type' => 'application/json' }, [data]] }
  end

  let(:app) { described_class.new(iapp) }

  context 'with invalid payload' do
    let(:params) { '{invalid json}' }

    it 'returns the bad request status code' do
      post '/echo', params, headers: request_headers

      expect(response_status).to eq(400)
    end

    it 'returns the invalid json response' do
      post '/echo', params, headers: request_headers

      expect(response_body[:error][:code]).to eq('invalid_json')
    end
  end

  context 'with valid payload' do
    let(:params) { ::Aux.h2json(message: 'BodyParser') }

    it 'returns ok status code' do
      post '/echo', params, headers: request_headers

      expect(response_status).to eq(200)
    end

    it 'returns the expected response' do
      post '/echo', params, headers: request_headers

      expect(last_response.body).to eq(data)
    end
  end
end
