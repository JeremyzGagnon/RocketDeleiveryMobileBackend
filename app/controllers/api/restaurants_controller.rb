module Api
    class RestaurantsController < ActionController::Base
      skip_before_action :verify_authenticity_token
    
      def index
        data = JSON.parse(request.body.read)

        puts "MY DATA"
        puts data
        puts "RATING"
        puts data["rating"]
        rating = data["rating"]
        puts "PRICE RANGE"
        puts data["price_range"]
        range = data["price_range"]

        @orders = Order.where(restaurant_rating: rating)
        puts json:  @orders

        # !restaurant = Restaurant.where(price_range: range)

        # if restaurant
        #     puts "ok"
            
        # elsif rating > 5
        #     render json: { error: "Invalid rating or price range" }
        # else
        #     render json: { error: "Invalid rating or price range" }
        # end

      end
  end
end