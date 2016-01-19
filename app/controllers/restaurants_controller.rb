class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
   @restaurants = Restaurant.new 
  end
  
  def create
    @restaurant = Restaurant.create(restaurant_params)
    redirect_to "/restaurants"
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = "Restaurant deleted successfully. Happy now?"
    redirect_to "/restaurants"
  end

end
