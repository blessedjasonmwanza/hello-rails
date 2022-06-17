require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.new(name: 'Blesssed Jason Mwanza', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Passion Driven software developer with a keen enthusiam for creating impact driven software')
  post = Post.create(author: user, title: '1 post', text: 'first post')
  it 'tests if the Like model is created correctly' do
    like = Like.create(author: user, post: post)
    expect(like.author).to eq user
    expect(like.post).to eq post
  end

  it 'updates a post\'s likes correctly' do
    Like.create(author: user, post: post)
    Like.create(author: user, post: post)
    Like.create(author: user, post: post)
    expect(post.likes_counter).to eq 4
  end
end