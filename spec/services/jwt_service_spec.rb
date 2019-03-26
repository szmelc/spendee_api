# frozen_string_literal: true

RSpec.describe JwtService do
  subject { described_class }

  let(:payload) { { 'one' => 'two' } }
  let(:token) { '...' }

  describe '.encode' do
    xit { expect(subject.encode(payload)).to eq(token) }
  end

  describe '.decode' do
    xit { expect(subject.decode(token)).to eq(payload) }
  end
end
