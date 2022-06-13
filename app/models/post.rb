class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  def increase_posts_counter
    author.increment!(:posts_counter)
  end

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end
end
