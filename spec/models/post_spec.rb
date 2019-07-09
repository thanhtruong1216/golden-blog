require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    post = FactoryBot.create(:post)
    expect(post).to be_valid
  end

  it 'is invalid without a content' do
    post_content = FactoryBot.build(:post, content: nil)
    expect(post_content).not_to be_valid
  end

  it 'is invalid without a photo attached' do
    post = FactoryBot.build(:post, photo: nil)
    expect(post).not_to be_valid
  end

  it 'is invalid when user is unknown' do
    post = FactoryBot.build(:post, user: nil)
    expect(post).not_to be_valid
  end

  it 'expect max length of post content is less than or equal to 200' do
    post_content = FactoryBot.build(:post).content.length
    expect(post_content).to be <= 200
  end
end
