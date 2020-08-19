# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RequestId do
  let(:http_request_id) { 'HTTP_REQUEST_ID' }
  let(:request_id) { 'Request-Id' }

  let(:iapp) do
    ->(_env) { [200, { 'Content-Type' => 'application/json' }, [{ data: { message: 'RequestTiming' } }]] }
  end

  let(:app) { described_class.new(iapp) }

  it 'sets the request id request header' do
    get '/'
    expect(last_request).to have_header(http_request_id)
  end

  it 'sets the request id response header' do
    get '/'
    expect(response_headers.keys).to include(request_id)
  end

  it 'sets the same request id both on request and response header' do
    get '/'
    expect(response_headers[request_id]).to eq(last_request.get_header(http_request_id))
  end

  it 'does not override given request_id header' do
    header(request_id, 'GIVEN-REQ-ID')
    get '/'
    expect(response_headers[request_id]).to eq(last_request.get_header(http_request_id))
  end
end
