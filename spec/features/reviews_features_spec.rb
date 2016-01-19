require "rails_helper"

feature "Reviewing"  do
  before {Restaurant.create name: "Homeslice Pizza"}


  scenario "Allows users to leave a review using a form" do
    visit "/restaurants"
    click_link "Review Homeslice Pizza"
    fill_in "Thoughts", with: "Dench"
    select "3", from: "Rating"
    click_button "Leave Review"
    expect(current_path).to eq "/restaurants"
    expect(page).to have_content "Dench"
  end


end