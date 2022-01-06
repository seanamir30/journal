require 'rails_helper'

RSpec.describe 'Devise Authentication', type: :feature do

    describe 'Log in' do
      let!(:user) { create(:user) }

      it 'shows the login page' do
        visit new_user_session_path
        expect(page).to have_content('Log in')
      end

      it 'should display a notice when email is invalid' do
        visit new_user_session_path
        fill_in('Email', :with => "WRONG EMAIL")
        fill_in('Password', :with => user.password)
        click_on('Log in')
        
        expect(page).to have_current_path(new_user_session_path)
      end

      it 'should display a notice when password is invalid' do
        visit new_user_session_path
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => "WRONG PASSWORD")
        click_on('Log in')
        
        expect(page).to have_current_path(new_user_session_path)
      end

      it 'should redirect the user to dashboard on successful login' do
        visit new_user_session_path
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => user.password)
        click_on('Log in')
        
        expect(page).to have_current_path(root_path)
      end
    end

    describe 'Sign up' do
      let!(:user) { 
        User.new(
          email: "email@gmail.com",
          password: "password",
        )
      }

      it 'shows the signup page' do
        visit new_user_registration_path
        expect(page).to have_content('Sign up')
      end

      it 'should display a notice when email is blank' do
        visit new_user_registration_path
        fill_in('Password', :with => user.password)
        fill_in('Password confirmation', :with => user.password)
        click_on('Sign up')
        
        expect(page).to have_current_path(user_registration_path)
      end

      it 'should display a notice when password is blank' do
        visit new_user_registration_path
        fill_in('Email', :with => user.email)
        fill_in('Password confirmation', :with => user.password)
        click_on('Sign up')
        
        expect(page).to have_current_path(user_registration_path)
      end

      it 'should display a notice when password confirmation does not match password' do
        visit new_user_registration_path
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => user.password)
        fill_in('Password confirmation', :with => "")
        click_on('Sign up')
        
        expect(page).to have_current_path(user_registration_path)
      end

      it 'should redirect the user to dashboard on successful signup' do
        visit new_user_registration_path
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => user.password)
        fill_in('Password confirmation', :with => user.password)
        click_on('Sign up')
        
        expect(page).to have_current_path(root_path )
      end
    end

end