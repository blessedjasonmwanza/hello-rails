require 'rails_helper'
RSpec.describe 'On Post Index Page', type: :feature do
  before(:each) do
    Comment.delete_all
    Post.delete_all
    User.delete_all
    @user = User.new(name: 'Blessed Jason Mwanza',
                     email: 'mwanzabj@gmail.com',
                     bio: 'Software Developer from Zambia',
                     password: 'password',
                     password_confirmation: 'password')
    @user.skip_confirmation!
    @user.save!

    visit user_session_path
    within('#new_user') do
      fill_in 'Email', with: 'mwanzabj@gmail.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    @post1 = Post.create!(title: 'post 1', text: 'My post 1', author_id: @user.id)

    @saadat = User.new(
      name: 'Saadat', bio: 'my bio', email: 'saadat@gmail.com',
      password: 'saadat1234', password_confirmation: 'saadat1234')
    @saadat.skip_confirmation!
    @saadat.save!

    Comment.create!(text: 'Nice', author_id: @saadat.id, post_id: @post1.id)
    Comment.create!(text: 'Very good', author_id: @saadat.id, post_id: @post1.id)
    visit user_post_path(id: @post1.id, user_id: @user.id)
  end
  describe 'post' do
    it 'post title ' do
      expect(page).to have_content 'post 1'
    end
    it 'test who wrote the post.' do
      expect(page).to have_content 'Blessed Jason Mwanza'
    end
    it 'test how many comments it has.' do
      expect(page).to have_content 'Comments 2'
    end
    it 'test how many likes it has.' do
      expect(page).to have_content 'Likes 0'
    end
    it 'test the post body.' do
      expect(page).to have_content 'My post 1'
    end
    it 'test the username of commentor.' do
      expect(page).to have_content 'Saadat'
    end
  end
end