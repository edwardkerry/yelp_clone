class Restaurant < ActiveRecord::Base

  validates :name, length: {minimum: 3}, uniqueness: true

  has_many :reviews, dependent: :destroy
  belongs_to :user
  has_attached_file :image,
                    :styles => { :medium => "300x300", :thumb => "100x100"},
                    :default_url =>"/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

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
    reviews.average(:rating)
  end
end
