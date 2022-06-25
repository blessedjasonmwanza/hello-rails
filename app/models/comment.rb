class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  validates :text, presence: true
  validates :author_id, presence: true
  validates :post_id, presence: true

  after_save :increase_post_comment_counter
  
  after_destroy :decrease_post_comment_counter

  def increase_post_comment_counter
    post.increment!(:comments_counter)
  end

  def decrease_post_comment_counter
    post.decrement!(:comments_counter) unless post.comments_counter.zero?
  end
end
