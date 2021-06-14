require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }
  subject { build(:user) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.not_to allow_value('123@email').for(:username) }
end
