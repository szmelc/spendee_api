# frozen_string_literal: true

require 'rails_helper'

describe AuthenticateUserCommand do
  include ActiveSupport::Testing::TimeHelpers

  let!(:user) { create(:user, id: 1, email: 'test@test.com') }

  context 'with right user and password' do
    subject { described_class.call(user.email, 'password123') }

    before(:each) { travel_to Time.zone.local(2017, 1, 1, 0, 0, 1, 1) }

    after(:each) { travel_back }

    let(:expected_token) do
      'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX2VtYWlsIjoidG' \
      'VzdEB0ZXN0LmNvbSIsImV4cCI6MTU1MzM2Mjk2MH0.S1LvqEj90GrYBpyb6vYw' \
      '0Yo8lODphVDN_jnF-n59K9c"'
    end

    xit { expect(subject.success?).to be }
    xit { expect(subject.result).to eq expected_token }
  end

  context 'with right user and wrong password' do
    subject { described_class.call(user.email, 'hackerman123') }

    it { expect(subject.success?).to_not be }
    it { expect(subject.result).to_not be }
  end

  context 'with everything wrong' do
    subject { described_class.call('dhh@rails.local', 'hackerman123') }

    it { expect(subject.success?).to_not be }
    it { expect(subject.result).to_not be }
  end
end
