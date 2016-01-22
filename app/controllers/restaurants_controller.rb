class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
   @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to "/restaurants"
    else
      render "new"
    end
  end

  def restaurant_params
    new_params = params.require(:restaurant).permit(:name, :description)
    new_params[:user_id] = current_user.id
    new_params
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if current_user.id == @restaurant.user_id
      @restaurant.destroy
      flash[:notice] = "Restaurant deleted successfully. Happy now?"
    else
      flash[:notice] = "Unable to delete this restaurant"
    end
    redirect_to "/restaurants"
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    if current_user.id == @restaurant.user_id
      render 'edit'
    else
      flash[:notice] = "Unable to edit this restaurant"
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to "/restaurants"
  end

end
