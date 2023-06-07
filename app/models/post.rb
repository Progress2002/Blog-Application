class Post < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'
    has_many :comments
    has_many :likes

    def update_counter(user_id)
        user = User.find_by(id: user_id)
        user.posts_counter = Post.where(user_id: user_id).count
        user.save
    end

    def recent_comment
        Comment.where(post_id: id).order(created_at: :desc).limit(5)
    end
end