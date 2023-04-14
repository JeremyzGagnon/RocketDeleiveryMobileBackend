module Api
    class RestaurantsController < ActionController::Base
      skip_before_action :verify_authenticity_token
    
      def index
        rating = params[:rating].to_i
        price_range = params[:price_range]

        if price_range.to_i > 3 || price_range.to_i < 0 || rating < 0 || rating > 5
          render json: { error: "Invalid rating or price range"},status: :unprocessable_entity
          return
        end 
      
        # Retrieve the list of restaurants that have at least one order with the specified rating
        @restaurants = Restaurant.joins(:orders).where(orders: { restaurant_rating: rating })
      
        # Filter the list of restaurants by price range, if specified
        @restaurants = @restaurants.where(price_range: price_range) if price_range.present?
      
        # Create a new hash with the modified rating value
        restaurants_with_rating = @restaurants.map do |restaurant|
          { id: restaurant.id, name: restaurant.name, price_range: restaurant.price_range, rating: rating }
        end
      
        render json: restaurants_with_rating.to_json
      end
    end
end