# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user) 
      expect(user).to be_valid
    end

    it 'is not valid without a username' do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      existing_user = create(:user, email: 'test@example.com')
      new_user = build(:user, email: 'test@example.com')
      expect(new_user).not_to be_valid
    end

    it 'is not valid without a phone' do
      user = build(:user, phone: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without a role' do
      user = build(:user, role: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'roles' do
    it 'can have a role of User' do
      user = build(:user, role: 'User')
      expect(user).to be_valid
      expect(user.User?).to be_truthy
    end

    it 'can have a role of Admin' do
      user = build(:user, role: 'Admin')
      expect(user).to be_valid
      expect(user.Admin?).to be_truthy
    end
  end

  describe 'associations' do
    it 'has many comments' do
      user = create(:user)
      comment = create(:comment, user: user)
      expect(user.comments).to include(comment)
    end

    it 'destroys associated comments when destroyed' do
      user = create(:user)
      comment = create(:comment, user: user)
      user.destroy
      expect(Comment.exists?(comment.id)).to be_falsey
    end
  end
end
