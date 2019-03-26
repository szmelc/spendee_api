# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Expenses::Create, type: :request do
  let(:category) { create(:category) }

  describe 'POST /api/v1/expenses' do
    subject { post '/api/v1/expenses', headers: headers, params: params.to_json }

    context 'when params are valid' do
      let(:params) do
        {
          amount: 10.0.to_d,
          currency: 'USD',
          category_id: category.id,
          description: 'Sample description',
          name: 'Sample expense name'
        }
      end

      context 'not authenticated' do
        include_context 'not authenticated'
        it_behaves_like '401'
      end

      context 'when authenticated' do
        include_context 'authenticated'
        context 'when authorized' do
          include_context 'authorized', ExpensePolicy, :create?
          let(:response_body) { { expense: Expense.last.attributes } }

          it_behaves_like '201'

          it 'calls ExpenseServices::Create' do
            expect(ExpenseServices::Create).to receive(:call).with(user, params).once.and_return(Result::Success.new(data: Expense.last))
            subject
          end
        end

        context 'when not authorized' do
          include_context 'not authorized', ExpensePolicy, :create?
          it_behaves_like '404'
        end
      end
    end
  end
end
