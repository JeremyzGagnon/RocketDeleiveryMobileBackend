module Api
    class ProductsController < ActionController::Base
      skip_before_action :verify_authenticity_token
      
      def index
        data = JSON.parse(request.body.read)
        
        puts "DATA"
        puts data.class
        restaurant_id = data["restaurant"]
        puts "restaurant_id"
        puts restaurant_id 
        @products = Product.where(restaurant_id: restaurant_id)
        # puts "PRODUCT NAME"
        # puts @products.name
        # puts "PRODUCT ID"
        # puts @products.id
        # puts "PRODUCT COST"
        # puts @products.cost

        
        if @products
            products_array = []
            @products.each do |product|
              products_array << { id: product.id, name: product.name, cost: product.cost }
            end
            render json: products_array
                else
            render json: { error: "Invalid restaurant ID" }
        end
        end
    end
  end
  