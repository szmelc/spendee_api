# frozen_string_literal: true

require 'pundit/rspec'

RSpec.shared_examples 'grants access' do
  it 'grants access' do
    if record.present?
      expect(described_class).to permit(user, record)
    else
      expect(described_class).to permit(user)
    end
  end
end

RSpec.shared_examples 'denies access' do |translation_key|
  it 'denies access' do
    expect(described_class).to_not permit(user, record)
  end

  it 'has proper error message' do
    policy = described_class.new(user, record)

    permission = ::RSpec.current_example.metadata[:permissions].first
    policy.public_send(permission)
    error_message = policy.error_message
    translation_key = "policy.error.#{translation_key}"

    expect(error_message).to be_present
    expect(I18n.exists?(translation_key, :en)).to be true
    expect(I18n.t(translation_key)).to be_a(String)
    expect(error_message).to eq I18n.t(translation_key)
  end
end

RSpec.shared_examples 'grants access to everybody' do
  context 'authenticated' do
    let(:user) { build_stubbed(:user) }

    it_behaves_like 'grants access'
  end

  context 'not authenticated' do
    let(:user) { nil }

    it_behaves_like 'grants access'
  end
end

RSpec.shared_examples 'grants access to authenticated users' do
  context 'authenticated' do
    let(:user) { build_stubbed(:user) }

    it_behaves_like 'grants access'
  end

  context 'not authenticated' do
    let(:user) { nil }

    it_behaves_like 'denies access', 'user_authenticated'
  end
end

RSpec.shared_examples 'grants access to record owner' do
  context 'authenticated' do
    let(:user) { record.user }

    it_behaves_like 'grants access'

    context 'other User' do
      let(:user) { build(:user) }

      it_behaves_like 'denies access', 'record_owner'
    end
  end

  context 'not authenticated' do
    let(:user) { nil }

    it_behaves_like 'denies access', 'user_authenticated'
  end
end

RSpec.shared_examples 'grants access to parent owner' do
  context 'authenticated' do
    let(:user) { parent.user }

    it_behaves_like 'grants access'

    context 'other User' do
      let(:user) { build(:user) }

      it_behaves_like 'denies access', 'record_owner'
    end
  end

  context 'not authenticated' do
    let(:user) { nil }

    it_behaves_like 'denies access', 'user_authenticated'
  end
end

RSpec.shared_examples 'grants access to current user' do
  context 'authenticated' do
    let(:user) { record }

    it_behaves_like 'grants access'

    context 'other user' do
      let(:user) { build(:user) }

      it_behaves_like 'denies access', 'record_owner'
    end
  end

  context 'not authenticated' do
    let(:user) { nil }

    it_behaves_like 'denies access', 'user_authenticated'
  end
end

RSpec.shared_examples 'grants access to admin' do
  context 'admin' do
    let(:user) { build(:user, role: 'admin') }

    it_behaves_like 'grants access'
  end

  context 'admin role' do
    let(:user) { build(:user, role: 'admin_adder') }

    it 'denies access' do
      expect(described_class).to_not permit(user, record)
    end
  end

  context 'not admin' do
    let(:user) { build(:user) }

    it 'denies access' do
      expect(described_class).to_not permit(user, record)
    end
  end
end

RSpec.shared_context 'not authorized' do |policy_class, policy_method|
  before(:each) do
    policy = instance_double('policy', policy_method => false)
    allow(policy_class).to receive(:new).and_return(policy)
  end
end

RSpec.shared_context 'authorized' do |policy_class, policy_method|
  before(:each) do
    policy = instance_double('policy', policy_method => true)
    allow(policy_class).to receive(:new).and_return(policy)
  end
end
