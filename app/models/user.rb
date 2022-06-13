class User < ApplicationRecord
  def recent_posts
    posts.limit(3).order(created_at: :desc)
  end
end
