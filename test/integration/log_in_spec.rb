require 'rails_helper'

describe 'Login process', type: :feature do
  before :each do
    Comment.delete_all
    Like.delete_all
    Post.delete_all
    User.delete_all
    @user = User.new(name: 'Blessed Jason Mwanza',
                    email: 'mwanzabj@gmail.com',
                    bio: 'Software Developer from Zambia',
                    password: 'password',
                    password_confirmation: 'password',
                    created_at: '2022-06-15 01:40:30.027196000 +0000',
                    confirmed_at: '2022-06-14 21:22:04.937699')
    @user.skip_confirmation!
    @user.save!
  end

  context 'Elements on page display' do
    it 'Login form shows elements correct' do
      visit new_user_session_path
      sleep 2
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Log in')
    end

    it 'Receive error if log in fields are left blank' do
      visit new_user_session_path
      sleep 2
      click_button('Log in')
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'Receive error if data is incorrect' do
      visit new_user_session_path
      sleep 2
      within('form') do
        fill_in 'user_email', with: 'mwanzabj@gmail.com'
        fill_in 'user_password', with: '123sfd456'
      end
      click_button('Log in')
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'Redirect if data is correct' do
      visit new_user_session_path
      sleep 2
      within('form') do
        fill_in 'user_email', with: 'mwanzabj@gmail.com'
        fill_in 'user_password', with: 'password'
      end
      click_button('Log in')
      expect(page).to have_content 'Blessed Jason Mwanza'
    end
  end
end
