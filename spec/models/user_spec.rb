require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Blessed Jason Mwanza', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Passion Driven software developer with a keen enthusiam for creating impact driven software')
  end

  before { subject.save }

  it 'Name must be Present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Photo must be a string' do
    subject.Photo = 'photo source'
    expect(subject).to be_valid
  end

  it 'Posts counter must be equal or greater than zero' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Recent posts method must return last three posts' do
    post1 = Post.create(author: subject, title: 'Test One', text: 'first Test post')
    post2 = Post.create(author: subject, title: 'Test Two', text: 'second Test post')
    post3 = Post.create(author: subject, title: 'Test Three', text: 'third Test post')
    post4 = Post.create(author: subject, title: 'Test Four', text: 'fourth Test post')
    post5 = Post.create(author: subject, title: 'Test Five', text: 'fifth Test post')
    expect(subject.posts_counter).to eq 5
    expect(subject.recent_posts.length).to eq 3
    expect(subject.recent_posts).to include post5, post4, post3
    expect(subject.recent_posts).not_to include post1, post2
  end
end