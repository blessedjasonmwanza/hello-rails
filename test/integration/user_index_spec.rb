require 'rails_helper'

RSpec.describe 'Login Page', type: :system do
  describe 'user index page' do
    before :all do
      User.delete_all
      unless User.find_by(email: 'daniel1@gmail.com')
        user = User.new(
          name: 'Danny',
          email: 'daniel1@gmail.com',
          bio: 'Software Developer from Zambia',
          password: '123456',
          password_confirmation: '123456',
        )
        user.skip_confirmation!
        user.save!
      end
    end
    it 'test the users name and profile image' do
      unless User.find_by(email: 'test1@gmail.com')
        user = User.new(
          name: 'Test',
          email: 'test1@gmail.com',
          bio: 'Software Developer from Zambia',
          password: '123456',
          password_confirmation: '123456',
        )
        user.skip_confirmation!
        user.save!
      end
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'daniel1@gmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_content('Test')
      image = page.all('img')
      expect(image.size).to eql 2
    end

    it 'shows number of posts for each user' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'daniel1@gmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'

      expect(page).to have_content('Number of posts: 0')
    end
  end
end
