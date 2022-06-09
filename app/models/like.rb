class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_counter_for_post
  def self.update_counter_for_post(post)
    # method that updates the likes counter for a post.
    post.update(likesCounter: Like.where(post: post).count)
  end

  private

  def update_counter_for_post
    post.increment!(:likesCounter)
  end
end
