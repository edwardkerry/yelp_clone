require "rails_helper"

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "Should see a sign in link and a sign up link" do
      visit("/")
      expect(page).to have_link("Sign up")
      expect(page).to have_link("Sign in")
      expect(page).not_to have_link("Add a restuarant")
    end

    it "should not see sign out link" do
      visit("/")
      expect(page).not_to have_link("Sign out")
    end
  end

  context "user signed in in the homepage" do
    
    before do
      visit("/")
      click_link("Sign up")
      fill_in("Email", with: "test@example.com")
      fill_in("Password", with: "testtest123")
      fill_in("Password confirmation", with: "testtest123")
      click_button("Sign up")
    end

    it "should see sign out link" do
      expect(page).to have_content("Sign out")
    end

    it "should not see a sign in link and a sign up link" do
      expect(page).not_to have_link("Sign in")
      expect(page).not_to have_link("Sign up")
    end
  end

end
