require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReviewsHelper. For example:
#
describe ReviewsHelper, type: :helper do

  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(star_rating('N/A')).to eq 'N/A'
    end

    it 'converts the numerical rating into stars' do
      expect(star_rating(4)).to eq '★★★★☆'
    end
  end
end

def leave_review(restaurant_name: 'KFC', thoughts: 'so so', rating: '3')
  click_link "Review #{restaurant_name}"
  fill_in "Thoughts", with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave review'
end
