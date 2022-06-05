class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def self.update_counter_for_user(user)
    # method that updates the posts counter for the given user
    user.postCounter = Post.where(author: user).count
    user.save
  end

  def self.five_most_recent_comments(post)
    # method which returns the 5 most recent comments for the given post.
    Comment.where(post: post).order(created_at: :desc).limit(5)
  end

  def five_most_recent_comments
    # method which returns the 5 most recent comments for this post.
    Comment.where(post: self).order(created_at: :desc).limit(5)
  end
end
