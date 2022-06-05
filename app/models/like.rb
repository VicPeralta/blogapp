class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  # method that updates the likes counter for a post.
  def self.update_counter_for_post(post)
    post.likesCounter = Like.where(post: post).count
    post.save
  end
end
