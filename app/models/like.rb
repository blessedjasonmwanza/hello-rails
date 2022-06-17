class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  validates :author_id, presence: true
  validates :post_id, presence: true

  after_save :increase_post_like_counter

  def increase_post_like_counter
    post.increment!(:likes_counter)
  end
end
