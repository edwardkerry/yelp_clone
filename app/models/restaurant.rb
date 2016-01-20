class Restaurant < ActiveRecord::Base

  validates :name, length: {minimum: 3}, uniqueness: true

  has_many :reviews, dependent: :destroy
  belongs_to :user

  def was_created_by?(user)
    user.id === self.user_id
  end
end
