class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  
  after_save :update_counter_for_post

  def self.update_counter_for_post(post)
    # method that updates the comments counter for the given post
    post.update(commentsCounter: Comment.where(post: post).count)
  end

  private

  def update_counter_for_post
    post.increment!(:commentsCounter)
  end
end
