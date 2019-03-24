# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::Me::UserSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:serializer) { described_class.new(user) }

  let(:subject) { JSON.parse(serializer.to_json) }

  it 'returns an id that matches' do
    expect(subject['id']).to eql(user.id)
  end

  it 'returns an email that matches' do
    expect(subject['email']).to eql(user.email)
  end
end
