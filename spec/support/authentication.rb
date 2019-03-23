
# frozen_string_literal: true

RSpec.shared_context 'authenticated' do
  let(:headers) do
    {
      'ACCEPT' => 'application/vnd.api+json',
      'Authorization' => "Bearer #{access_token}"
    }
  end
  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id).token }
end

RSpec.shared_context 'not authenticated' do
  let(:id) { 1 }
  let(:headers) { { 'ACCEPT' => 'application/vnd.api+json' } }
end
