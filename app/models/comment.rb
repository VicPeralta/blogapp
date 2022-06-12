class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :increment_counter_for_post
  after_destroy :decrement_counter_for_post
  def self.update_counter_for_post(post)
    # method that updates the comments counter for the given post
    post.update(commentsCounter: Comment.where(post: post).count)
  end

  private

  def increment_counter_for_post
    post.increment!(:commentsCounter)
  end

  def decrement_counter_for_post
    post.decrement!(:commentsCounter)
  end
end
