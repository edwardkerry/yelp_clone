class Restaurant < ActiveRecord::Base

  validates :name, length: {minimum: 3}, uniqueness: true

  has_many :reviews, dependent: :destroy
  belongs_to :user

  def was_created_by?(user)
    user.id === self.user_id
  end

  def build_review(params, user)
    review = reviews.new(restaurant_id: self.id, thoughts: params[:thoughts],
                          rating: params[:rating])
    review.user_id = user.id
    return review
  end

  def average_rating
    return 'N/A' if reviews.count < 1
    reviews.average(:rating).to_i
  end
end
