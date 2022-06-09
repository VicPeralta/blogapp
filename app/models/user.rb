class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes
  validates :name, presence: { message: 'Name can not be blank' }
  validates :postCounter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
            message:'postCounter must be integer and >=0' }
  # To be used without a user instance
  def self.three_most_recent_posts(user)
    # method returns the 3 most recent posts for the given user
    Post.where(author: user).order(created_at: :desc).limit(3)
  end

  def three_most_recent_posts
    # method returns the 3 most recent posts by this user
    Post.where(author: self).order(created_at: :desc).limit(3)
  end
end
