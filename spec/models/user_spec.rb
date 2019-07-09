require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a user name' do
    user = FactoryBot.build(:user, user_name: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a full name' do
    user = FactoryBot.build(:user, full_name: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'expect max length of user_name is 16' do
    user_name_length = FactoryBot.build(:user).user_name.length
    expect(user_name_length).to be <= 16
  end

  it 'expect max length of full_name is 30' do
    full_name_length = FactoryBot.build(:user).full_name.length
    expect(full_name_length).to be <= 30
  end
end
