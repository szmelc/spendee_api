# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserServices::Register do
  describe '.call' do
    subject { described_class.call(params) }

    let(:email) { 'john.doe@example.com' }
    let(:password) { 'password' }
    let(:params) do
      {
        email: email,
        password: password,
        password_confirmation: 'password'
      }
    end

    context 'params are valid' do
      describe 'creates user' do
        it 'increases User count' do
          expect { subject }.to change { User.count }.by(1)
        end

        it 'creates user with proper email' do
          subject
          expect(User.last.email).to eq(params[:email])
        end
      end

      describe 'returns success result object' do
        it 'returns success result' do
          expect(subject.success?).to be true
        end
      end
    end

    context 'params are invalid' do
      let(:email) { 'john.doe' }
      let(:password) { 'pass' }

      it 'raises ActiveRecord::RecordInvalid error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
