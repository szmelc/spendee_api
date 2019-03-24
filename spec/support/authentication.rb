# frozen_string_literal: true

RSpec.shared_context 'authenticated' do
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{access_token}"
    }
  end
  let!(:user) { create(:user) }
  let(:access_token) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJleHAiOjE1NTM0NTU4ODd9.DpM1ysq050o-1-pCAcVQ3GK_FoZHhPL-JBFeZBfsU7M' }
end

RSpec.shared_context 'not authenticated' do
  let!(:user) { create(:user, email: 'not@test.com') }
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJleHAiOjE1NTM0NTU4ODd9.DpM1ysq050o-1-pCAcVQ3GK_FoZHhPL-JBFeZBfsU7a'
    }
  end
end
