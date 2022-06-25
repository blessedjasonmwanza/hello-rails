require 'user'

module Mocks
  def create_users
    names = [
      { name: 'Blessed Jason Mwanza', bio: "Passion Driven Software Engineer", posts_counter: 5, email: 'mwanzabj@gmail.com'},
      { name: 'John Doe', bio: "encoded", posts_counter: 5, email: 'john@gmail.com'}
    ]
    (0..1).each do |i|
      user = User.new(names[i])
      user.password = 'admin123'
      user.password_confirmation = 'admin123'
      user.skip_confirmation!
      user.save!
    end
    User.all
  end

  def create_posts(users)
    users.each do |user|
      (1..5).each do |j|
        Post.create(title: "Post # #{j}", text: "This is  my: #{j} post", comments_counter: 0,
                    likes_counter: 0, author_id: user.id)
      end
    end
    Post.all
  end

  def create_likes_comments(users, posts)
    posts.each do |post|
      (0..1).each do |m|
        Like.create(author_id: users[m].id, post_id: post.id)
        Comment.create(author_id: users[m].id, post_id: post.id,
                       text: "Hi  #{users[m].name}, this is a test comment.")
      end
    end
  end
end