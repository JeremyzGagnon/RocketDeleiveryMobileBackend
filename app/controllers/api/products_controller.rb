module Api
    class ProductsController < ActionController::Base
      skip_before_action :verify_authenticity_token
      
      def index
        restaurant_id = params[:restaurant]
      
        if restaurant_id.present?
          @products = Product.where(restaurant_id: restaurant_id).select(:id, :name, :cost)
      
          if @products.any?
            render json: @products
          else
            render json: { error: "Invalid restaurant ID" }, status: :unprocessable_entity
          end
        else
          @products = []
          render json: @products
        end
      end
              end
end
  