require "spec_helper"

describe Restaurant, type: :model  do

  it { is_expected.to have_many :reviews}


  it "removes reviews when restaurant is deleted" do
    restaurant = Restaurant.create(name: "Hooters")
    restaurant.reviews.create(thoughts: "good", rating: "2")
    expect{restaurant.destroy}.to change{restaurant.reviews.count}.by(-1)
  end

end