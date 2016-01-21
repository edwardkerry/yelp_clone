require 'rails_helper'

feature ">> User session <<" do

  context "When user is not signed in" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

    it 'should not allow not signed in users to add a restaurant' do
      visit '/'
      click_link 'Add a restaurant'
      expect(current_path).to eq '/users/sign_in'
    end
  end

  context "When user is signed in" do
    before { sign_up }
    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end
    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end
