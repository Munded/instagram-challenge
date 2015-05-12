require 'rails_helper'

describe Post, type: :model do
  it { is_expected.to have_many :comments }

  describe 'build_with_user' do

    let(:user) { User.create email: 'test@test.com' }
    let(:post) { Post.create name: 'Test' }

    subject(:like) { post.likes.build_with_user(user) }

    it 'builds a like' do
      expect(like).to be_a Like
    end

    it 'builds a like associated with the specified user' do
      expect(like.user).to eq user
    end
  end
end
