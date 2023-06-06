class Post < ApplicationRecord
    belong_to :user, foreign_key: 'author_id'
    has_many :comments
    has_many :likes
end