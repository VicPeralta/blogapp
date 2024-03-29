class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, class_name: 'Post', foreign_key: 'author_id', dependent: :destroy
  has_many :comments
  has_many :likes
  validates :name, presence: { message: 'Name can not be blank' }
  validates :postCounter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'postCounter must be integer and >=0' }

  before_create :add_token

  # To be used without a user instance
  def self.three_most_recent_posts(user)
    # method returns the 3 most recent posts for the given user
    Post.where(author: user).order(created_at: :desc).limit(3)
  end

  def three_most_recent_posts
    # method returns the 3 most recent posts by this user
    Post.where(author: self).order(created_at: :desc).limit(3)
  end

  def admin?
    role == 'admin'
  end

  def add_token
    self.token = ApiHelper::JsonWebToken.encode(email)
  end
end
