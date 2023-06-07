require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Sam', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Student', post_counter: 0)
  end

  befor { subject.save }

  context 'Testing validations' do
    it 'name should be present' do
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'post_counter should be a positive intiger' do
      expect(subject).to be_valid
      subject.post_counter = -5
      expect(subject).to_not be_valid
    end
  end

  context 'Testing behavior' do
    let(:user) { subject }

    before do
      5.times do
        Post.create!(author_id: user.id, title: 'Hello World', text: 'Text', comments_counter: 1,
                     likes_counter: 1)
      end
    end

    it 'list the 3  most recent post' do
      expect(user.recent_post).to eq 3
    end
  end
end
