require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }
  subject { build(:user) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.not_to allow_value('123@email').for(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive  }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive  }

  describe 'login' do
    it 'return login value' do
      user = build(:user)
      expect(user.login).to eq(user.username)
    end
  end

  describe 'has_one' do
    it 'return nil when no profile assign' do
      user = build(:user)
      expect(user.profile).to eq(nil)
    end
  end
end
