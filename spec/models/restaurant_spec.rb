require 'rails_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'is expected to have a name of over two letters' do
    restaurant = Restaurant.create(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

end
