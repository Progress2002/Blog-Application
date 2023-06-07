require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'sam', post_counter: 0) }

  subject do
    Post.new(user_id: user.id, title: 'Hello', text: ' This post was made by me', comments_counter: 1,
             likes_counter: 1)
  end

  before { subject.save }

  context 'testing validation' do
    it 'title should be present' do
      expect(subject).to be_valid
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should not exceed 250 characters' do
      expect(subject).to be <= 250
    end

    it 'comment_counter should be a positive intiger' do
      expect(subject).to be_valid
      subject.comment_counter = -2
      expect(subject).to_not be_valid
    end

    it 'like_counter should be a positive intiger' do
      expect(subject).to be_valid
      subject.like_counter = -2
      expect(subject).to_not be_valid
    end

    it 'should update count of posts' do
      expect(subject.update_counter).to be true
    end
  end

  context 'Testing behavior' do
    before { 10.times { Comment.create(author_id: user.id, post_id: subject.id, text: 'Text') } }
    it 'lists the most 5 recent posts' do
      expect(subject.recent_comments.length).to eq 5
    end
  end
end
