require 'rails_helper'

feature 'reviews' do

  before { Restaurant.create name: 'Charlies Chuck Wagon'}

    scenario 'adding a review' do
      visit '/restaurants'
      click_link "Charlies Chuck Wagon"
      click_link "Review Charlies Chuck Wagon"
      fill_in "Thoughts", with: "Oh boy, what a place"
      select "5", from: "Rating"
      click_button "Leave Review"
      expect(page).to have_content "Oh boy, what a place"
    end

end
