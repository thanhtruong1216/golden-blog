require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has a valid factory' do
    comment = FactoryBot.create(:comment)
    expect(comment).to be_valid
  end

  it 'is invalid without a comment content' do
    comment_content = FactoryBot.build(:comment, content: nil)
    expect(comment_content).not_to be_valid
  end
end
