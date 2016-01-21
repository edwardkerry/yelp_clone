require "rails_helper"

feature "reviewing" do
  let!(:nandos){Restaurant.create(name: "Nandos")}

  scenario "allows users to leave a review" do
    leave_review("I don't even like chicken", 3)
    expect(current_path).to eq "/restaurants"
    expect(page).to have_content "I don't even like chicken"
  end

  scenario "displays an average rating for all reviews" do
    leave_review("so so", 3)
    leave_review("Great", 5)
    expect(page).to have_content('Average rating: 4')
  end

  def leave_review(opinion, rating)
    visit "/restaurants"
    click_link "Review Nandos"
    fill_in "Opinion", with: opinion
    select rating, from: "Rating"
    click_button "Leave Review"
  end

end
