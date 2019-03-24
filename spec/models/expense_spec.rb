# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:currency) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:amount) }

    context 'when amount is 0' do
      subject { build(:expense, amount: 0) }

      it { is_expected.not_to be_valid }
    end
  end

  it { is_expected.to belong_to(:user) }
end
