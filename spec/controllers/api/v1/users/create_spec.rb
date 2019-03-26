# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::Create, type: :request do
  describe 'POST /api/v1/users' do
    subject { post '/api/v1/users', headers: headers, params: params }

    context 'when params are valid' do
      let(:params) { { email: 'test@test.com', password: '123123' } }
      let(:response_body) { { user: User.last.attributes } }

      it_behaves_like '201'
    end
  end
end
