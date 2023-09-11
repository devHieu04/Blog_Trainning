# spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      user = create(:user)
      comment = create(:comment, user: user)
      expect(comment.user).to eq(user)
    end

    it 'belongs to a post' do
      post = create(:post)
      comment = create(:comment, post: post)
      expect(comment.post).to eq(post)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it 'is not valid without a user' do
      comment = build(:comment, user: nil)
      expect(comment).not_to be_valid
    end

    it 'is not valid without a post' do
      comment = build(:comment, post: nil)
      expect(comment).not_to be_valid
    end

    it 'is not valid without content' do
      comment = build(:comment, content: nil)
      expect(comment).not_to be_valid
    end
  end
end
