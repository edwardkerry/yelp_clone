module ReviewsHelper

  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    '★' * rating.to_i + '☆' * (5 - rating.to_i)
  end
end
