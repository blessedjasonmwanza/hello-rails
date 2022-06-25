require 'rails_helper'
RSpec.describe 'On Post Index Page', type: :feature do
  before :each do
    Comment.delete_all
    Post.delete_all
    User.delete_all

    @user = User.new(
      name: 'Blessed Jason Mwanza',
      email: 'mwanzabj@gmail.com',
      bio: 'Software Developer from Zambia',
      password: 'password',
      password_confirmation: 'password'
    )
    @user.skip_confirmation!
    @user.save!
    visit user_session_path
    within('#new_user') do
      fill_in 'Email', with: 'mwanzabj@gmail.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    @post1 = Post.create!(title: 'post 1', text: 'My post 1', author_id: @user.id)
    @post2 = Post.create!(title: 'post 2', text: 'My post 2', author_id: @user.id)
    @post3 = Post.create!(title: 'post 3', text: 'My post 3', author_id: @user.id)
    jane = User.new(name: 'Jane Doe',
                    email: 'janedoe@gmail.com',
                    bio: 'Software Developer from Zambia',
                    password: 'password',
                    password_confirmation: 'password')
    jane.skip_confirmation!
    jane.save!
    Comment.create(text: 'Nice', post_id: @post1.id, author_id: jane.id)
    Comment.create(text: 'Great', post_id: @post1.id, author_id: jane.id)
    Comment.create(text: 'Cool', post_id: @post1.id, author_id: jane.id)
    visit user_posts_path(@user)
  end

  describe 'post' do
    it 'test username' do
      expect(page).to have_content 'Jane'
    end
    it 'see the number of posts the user has written' do
      expect(page).to have_content 'Number of posts: 3'
    end
    it 'test posts title.' do
      expect(page).to have_content 'post 1'
      expect(page).to have_content 'post 2'
      expect(page).to have_content 'post 3'
    end
    it 'test the posts body.' do
      expect(page).to have_content 'My post 1'
      expect(page).to have_content 'My post 2'
      expect(page).to have_content 'My post 3'
    end
    it 'test the comments on a post.' do
      expect(page).to have_content 'Nice'
      expect(page).to have_content 'Great'
      expect(page).to have_content 'Cool'
    end
    it 'test the number of comments' do
      expect(page).to have_content 'Comments 3'
    end
    it 'how many likes a post has.' do
      expect(page).to have_content 'Likes 0'
    end
    it 'when i click post it redirects to post page' do
      click_link 'post 1'
      expect(page).to have_current_path(user_post_path(@user, @post1))
    end
    it 'The user photo is displayed' do
      img = page.all('img')
      puts plain: img[0][:alt]
      expect(img[0][:alt]).to include(@user.name)
      expect(img[0][:src]).not_to be('')
    end
  end
end
