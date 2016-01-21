require 'rails_helper'

feature '>> Reviewing <<' do
  before do
    sign_up
    add_restaurant(name: 'KFC')
  end

  scenario 'allows users to leave a review using a form' do
     visit '/restaurants'
     leave_review(restaurant_name: 'KFC', thoughts: 'so so', rating: '3')
     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

  scenario 'allows users to only leave one review per restaurant' do
     visit '/restaurants'
     leave_review(restaurant_name: 'KFC', thoughts: 'so so', rating: '3')
     expect(page).not_to have_link 'Review KFC'
  end

  scenario 'reviews can be deleted only by those who create them' do
     visit '/restaurants'
     leave_review(restaurant_name: 'KFC', thoughts: 'so so', rating: '3')
     click_link 'Delete review'
     expect(page).to have_content 'Your review was deleted succesfully'
  end

  scenario 'reviews can be deleted only by those who create them' do
     visit '/restaurants'
     leave_review(restaurant_name: 'KFC', thoughts: 'so so', rating: '3')
     click_link 'Sign out'
     expect(page).not_to have_link 'Delete review'
  end

end
