require 'rails_helper'

feature "User sign in" do
  context "user not signed in and on homepage" do
    it 'can see sign in and out links' do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it 'can not see sign out link' do
      visit('/')
      expect(page).to_not have_link('Sign out')
    end
  end

  context 'user signed in and on homepage' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: "test@test.com")
      fill_in('Password', with: "password123")
      fill_in('Password confirmation', with: "password123")
      click_button('Sign up')
    end

    it 'should see sign out link' do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it 'should not see sign in and sign up links' do
      visit('/')
      expect(page).not_to have_link("Sign in")
      expect(page).not_to have_link("Sign up")
    end
  end


end
