require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'has a valid factory' do
    like = FactoryBot.create(:like)
    expect(like).to be_valid
  end

  it 'is invalid when user is unknown' do
    like_user = FactoryBot.build(:like, user: nil)
    expect(like_user).not_to be_valid
  end

  it 'is invalid when post is unknown' do
    like_post = FactoryBot.build(:like, post: nil)
    expect(like_post).not_to be_valid
  end
end
