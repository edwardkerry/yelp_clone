require 'rails_helper'

feature '>> Restaurants interaction <<' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'resturants have been added' do
    before { Restaurant.create(name: 'KFC', image: nil) }
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).to have_css("img", 'missing.png')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    before { sign_up }
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      add_restaurant(name: 'KFC')
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        add_restaurant(name: 'KF')
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'Name is too short'
      end
    end
  end

  context 'editing restaurants' do
    before do
      sign_up
      add_restaurant(name: 'KFC')
    end
    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_css 'h1',text: 'Kentucky Fried Chicken'
    end

    scenario 'prevents a user from editing a restaurant not added by them' do
      click_link 'Sign out'
      visit '/restaurants'
      expect(page).not_to have_content 'Edit KFC'
    end
  end

  context 'deleting restaurants' do
    before do
      sign_up
      add_restaurant(name: 'KFC')
    end
    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'prevents a user from editing a restaurant not added by them' do
      click_link 'Sign out'
      visit '/restaurants'
      expect(page).not_to have_content 'Delete KFC'
    end
  end

end
