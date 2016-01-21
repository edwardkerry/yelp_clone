class Review < ActiveRecord::Base

  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }

  belongs_to :restaurant
  belongs_to :user
  validates :rating, inclusion: (1..5)
end
