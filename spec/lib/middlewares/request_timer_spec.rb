# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RequestTimer do
  let(:iapp) do
    ->(_env) { [200, { 'Content-Type' => 'application/json' }, [{ data: { message: 'RequestTiming' } }]] }
  end

  let(:app) { described_class.new(iapp) }

  it 'sets the correct timing response header' do
    get '/'
    expect(response_headers.keys).to include('Elapsed')
  end
end
