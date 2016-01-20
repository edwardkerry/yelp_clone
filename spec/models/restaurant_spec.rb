require "spec_helper"

describe Restaurant, type: :model  do

  it { is_expected.to have_many :reviews}
  it {should belong_to(:user)}

  it "removes reviews when restaurant is deleted" do
    restaurant = Restaurant.create(name: "Hooters")
    restaurant.reviews.create(thoughts: "good", rating: "2")
    expect{restaurant.destroy}.to change{restaurant.reviews.count}.by(-1)
  end

  it "is not a valid name if it's less than three chars long" do
    restaurant = Restaurant.create(name: "YO")
    expect(restaurant).not_to be_valid
    expect(restaurant).to have(1).error_on(:name)
  end

  it "is not valid unless it has a unique name" do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end
end

