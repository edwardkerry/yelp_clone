require 'rails_helper'

feature '<< endorsing reviews >>' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
  end

  scenario 'A user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse review'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'A user can endorse a review many times' do
    visit '/restaurants'
    20.times {click_link 'Endorse review'}
    expect(page).to have_content('20 endorsements')
  end

end
