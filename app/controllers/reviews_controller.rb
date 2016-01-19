class ReviewsController < ApplicationController

  def new
    @restuarant = Restaurant.find(params[:restaurant_id])
    session[:restid] = params[:restaurant_id]
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    redirect_to ("/restaurants/#{session[:restid]}")
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
