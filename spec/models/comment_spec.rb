require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'adds comments' do
    author = User.new(name: 'Tom', photo: 'profile_pic.jpeg', bio: 'Bio text template', posts_counter: 0)
    post = Post.new(title: 'New test post', text: 'How are ', author: author, likes_counter: 0, comments_counter: 0)
    post.save!

    comment_creator = User.new(name: 'Jerry', photo: 'profile_pic.jpeg', bio: 'Bio template', posts_counter: 0)
    comment_creator.save!

    post.comments.create!(text: 'Hi World', author: comment_creator)
    post.comments.create!(text: 'This is actually my second post', author: comment_creator)
    expect(post.comments.length).to eql(2)
  end
end
