class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    #@restaurants = Restaurant.where(user: current_user)
    @restaurants = policy_scope(Restaurant)
  end

  def show
    authorize @restaurant
  end

  def new
    byebug
    @restaurant = Restaurant.new
    authorize @restaurant
    byebug
  end

  def edit
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    authorize @restaurant
    @restaurant.user = current_user
      if @restaurant.save
        redirect_to @restaurant, notice: 'Restaurant was successfully created.'
      else
        render :new
    end
  end

  def update
    authorize @restaurant
      if @restaurant.update(restaurant_params)
        redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
      else
       render :edit
      end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    authorize @restaurant
    @restaurant.destroy
      redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
end
