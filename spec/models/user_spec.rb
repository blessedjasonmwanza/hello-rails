require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Blessed Jason Mwanza', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
             bio: 'Passion Driven software developer with a keen enthusiam for creating impact driven software')
  end

  before :each do
    subject.save
  end

  it 'Name must be Present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Photo must be a string' do
    subject.photo = 'photo source'
    expect(subject).to be_valid
  end

  it 'Posts counter must be equal or greater than zero' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end
end
