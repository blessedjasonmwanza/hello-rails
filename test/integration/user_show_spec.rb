require 'rails_helper'

RSpec.describe 'Show User page', type: :system do
  describe 'show user page' do
    before :all do
      Comment.delete_all
      Post.delete_all
      User.delete_all
      unless User.find_by(email: 'mwanzabj@gmail.com')
        @user = User.new(name: 'Blessed Jason Mwanza',
                         email: 'mwanzabj@gmail.com',
                         bio: 'Software Developer from Zambia',
                         password: 'password',
                         password_confirmation: 'password')
        @user.skip_confirmation!
        @user.save!
        @post1 = Post.create(title: 'post 1', text: 'My first post', author_id: @user.id,
                             likes_counter: 0)
        @post2 = Post.create(title: 'post 2', text: 'My second post', author_id: @user.id,
                             likes_counter: 0)
        @post3 = Post.create(title: 'post 3', text: 'My third post', author_id: @user.id,
                             likes_counter: 0)
        @comment1 = Comment.create(text: 'My comment', author_id: @user.id, post_id: @post1.id)
      end
    end

    it 'render the user name and the Bio' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'mwanzabj@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      name = find('h2 a')
      name.click
      expect(page).to have_content('Blessed Jason Mwanza')
      expect(page).to have_content('Software Developer from Zambia')
    end

    it 'shows the number of posts' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'mwanzabj@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      name = find_all('h2 a')
      name[0].click
      name = find('.user_card .content p')
      expect(page).to have_content('Number of posts: 3')
    end

    it 'redirects to the correct path' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'mwanzabj@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      name = find_all('h2 a')
      name[0].click
      puts current_path
      expect(page).to have_current_path("/users/#{@user.id}")
    end

    it 'show the 3 first posts and view all posts button' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'mwanzabj@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      name = find_all('h2 a')
      name[0].click
      expect(page).to have_content('post 1')
      expect(page).to have_content('post 2')
      expect(page).to have_content('post 3')
      expect(page).to have_link('See all posts')
    end
  end
end