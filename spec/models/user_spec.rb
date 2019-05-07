# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:expenses).dependent(:destroy) }
    it { is_expected.to have_many(:monthly_incomes).dependent(:destroy) }
  end
end
