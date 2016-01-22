require 'rails_helper'

feature '<< endorsing reviews >>' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
  end

  scenario 'A user can endorse a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse review'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'A user can endorse a review many times', js: true do
    visit '/restaurants'
    click_link 'Endorse review'
    sleep(2)
    click_link 'Endorse review'
    expect(page).to have_content('2 endorsements')
  end

end
