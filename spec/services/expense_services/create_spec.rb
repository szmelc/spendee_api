# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpenseServices::Create do
  subject { described_class.call(user, params) }

  let!(:category) { create(:category) }
  let!(:user) { create(:user) }
  let(:params) do
    {
      amount: 10.15,
      currency: 'EUR',
      category_id: category.id,
      description: 'Christmas Grocery Shopping',
      name: 'Groceries'
    }
  end

  describe '#call' do
    context 'when params are valid' do
      it 'creates new expense' do
        expect { subject }.to change { Expense.count }.by(1)
      end

      it 'creates an expense with proper name' do
        subject
        expect(Expense.last.name).to eq(params[:name])
      end

      it 'returns success result' do
        expect(subject.success?).to be true
      end

      it 'assigns a category to the expense' do
        subject
        expect(Expense.last.category).to_not be_nil
      end
    end

    context 'when params are invalid' do
      context 'when necessary param is missing' do
        before(:each) { params.delete(:amount) }

        it 'raises ActiveRecord::RecordInvalid error' do
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
