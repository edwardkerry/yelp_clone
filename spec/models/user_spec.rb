require "rails_helper"

describe User, type: :model do
  
  it {is_expected.to have_many :restaurants}
  it {is_expected.to have_many :reviews}

  describe "Adding a restaurant" do
  
    it "won't let you add a restaurant if not signed in" do
      restaurant = Restaurant.create(name: "Hooters")
      expect(restaurant).to have(1).error_on(:user_id)
      expect(restaurant).not_to be_valid
    end


  end

end
