# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_inclusion_of(:name).in_array(Category::NAMES) }
    it { is_expected.to validate_numericality_of(:ordering) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:expenses) }
  end
end
