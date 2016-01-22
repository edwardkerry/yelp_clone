require "rails_helper"

feature "restaurants" do

  before do
    visit  "/users/sign_up"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    click_button "Sign up"
  end

  context "No restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet!"
      expect(page).to have_link "Add a restaurant"
    end
  end
  context "restaurants have been added" do
    before do
      Restaurant.create(name: "Hooters")
    end

    scenario "display restaurants" do
      visit "/restaurants"
      expect(page).to have_content("Hooters")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario "User must be logged in before creating a restaurant" do
       visit '/restaurants'
       click_link "Sign out"
       click_link 'Add a restaurant'
       expect(current_path).to eq '/users/sign_in'
    end

  end

  context 'viewing restaurants' do

    let!(:hooters){Restaurant.create(name:'Hooters')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Hooters'
      expect(page).to have_content 'Hooters'
      expect(current_path).to eq "/restaurants/#{hooters.id}"
    end

  end

  context 'deleting restaurants' do

    before do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
    end

    scenario 'removes a restaurant when associated user clicks delete link' do
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'does not allow unassociated user to delete link' do
      click_link 'Sign out'
      user_2_sign_in
      click_link 'Delete KFC'
      expect(page).not_to have_content 'Restaurant deleted successfully'
    end
  end

  context 'updating restaurants' do
    before do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
    end

    scenario 'a user may edit their restaurant' do
      click_link 'Edit KFC'
      fill_in "Name", with: "New one"
      fill_in "Description", with: "1234"
      click_button "Update Restaurant"
      expect(current_path).to eq('/restaurants')
      expect(page).to have_content("New one")
    end

    scenario 'a user may not edit another restaurant' do
      click_link 'Sign out'
      user_2_sign_in
      click_link 'Edit KFC'
      expect(page).to have_content("Unable to edit this restaurant")
    end

  end

  context "an invalid restaurant" do
    it "does not let you submit a name that is too short" do
      visit "/restaurants"
      click_link "Add a restaurant"
      fill_in "Name", with: "AD"
      click_button "Create Restaurant"
      expect(page).not_to have_css "h2", text: "AD"
      expect(page).to have_content "error"
    end
  end

  def user_2_sign_in
    visit  "/users/sign_up"
    fill_in "Email", with: "user2@test.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    click_button "Sign up"
  end


end
