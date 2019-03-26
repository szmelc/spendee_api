# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::Me::Show, type: :request do
  describe 'GET /api/v1/users/me' do
    subject { get '/api/v1/users/me', headers: headers }

    context 'not authenticated' do
      include_context 'not authenticated'
      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      context 'authorized' do
        include_context 'authorized', UserPolicy, :me?
        let(:response_body) { current_user_attributes(user, API::V1::Users::Me::UserSerializer) }

        it_behaves_like '200'
      end

      context 'not authorized' do
        include_context 'not authorized', UserPolicy, :me?
        it_behaves_like '404'
      end
    end
  end
end
