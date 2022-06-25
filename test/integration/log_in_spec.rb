require 'rails_helper'

describe 'Login process', type: :feature do
  before :each do
    @user = User.new(name: 'Blessed Jason Mwanza',
          email: 'mwanzabj@gmail.com',
          bio: 'Software Developer from Zambia',
          password: 'password',
          password_confirmation: 'password')
    @user.skip_confirmation!
    @user.save!
  end

  context 'Elements on page display' do
    it 'Login form shows elements correct' do
      visit new_user_session_path
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Log in')
    end
  end
  context 'User interaction on log in form' do
    it 'Receive error if log in fields are left blank' do
      visit new_user_session_path
      click_button('Log in')
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'Receive error if data is incorrect' do
      visit new_user_session_path
      within('form') do
        fill_in 'user_email', with: 'mwanzabj@gmail.com'
        fill_in 'user_password', with: '123sfd456'
      end
      click_button('Log in')
      expect(page).to have_content 'Invalid Email or password.'
    end
    it 'Redirect if data is correct' do
      visit new_user_session_path
      within('form') do
        fill_in 'user_email', with: 'mwanzabj@gmail.com'
        fill_in 'user_password', with: 'password'
      end
      click_button('Log in')
      expect(page).to have_content 'Blessed Jason Mwanza'
    end
  end
end