module Api
    class OrdersController < ActionController::Base
      skip_before_action :verify_authenticity_token
      
      def index
        type = params[:type]
        id = params[:id]

        if type.nil? && id.nil?
          render json: { error: "Both 'user type' and 'id' parameters are required" }, status: :bad_request
          return
        end

        if ['customer', 'restaurant', 'courier'].exclude?(type)
          render json: { error: "Invalid user type parameter"}, status: :unprocessable_entity
        end
        if type == "customer"
          @order = Order.where(customer_id: id)
          render json: @order
          
        elsif type == "restaurant"
          @order = Order.where(restaurant_id: id)
          render json: @order

        elsif type == "courier"
          @order = Order.where(courier_id: id)
          render json: @order
          
        end

      end

      def create
        restaurant_id = params[:restaurant_id]
        restaurant = Restaurant.find_by(id: restaurant_id)
        customer_id = params[:customer_id]
        customer = Customer.find_by(id: customer_id)
        products = params[:products]

        if restaurant_id.nil? || customer_id.nil? || products.nil? || products.empty?
          render json: { error: "Restaurant ID, customer ID, and products aer required"}, status: :bad_request
          return
        end

        if restaurant.nil? || customer.nil?
          render json: { error: "Invalid restaurant or customer ID" }, status: :unprocessable_entity
          return
        end

        @order = Order.new(restaurant: restaurant, customer: customer, order_status: OrderStatus.find_by(name: "pending"))

        if @order.save
          products.each do |product|
            product_order = ProductOrder.new(order: @order, product_id: product[:id], product_quantity: product[:quantity], product_unit_cost: product[:cost])
            unless product_order.save
              @order.destroy
              render json: { error: "Invalid product ID" }, status: :unprocessable_entity
              return
            end
          end
        else
          render json: { error: "Fsiled to create the oder" }, status: :unprocessable_entity
          return
        end

        render json: @order, status: :ok
      end
      

      def set_status
        id = params[:id]
        status = params[:status]
        if ['pending', 'in progress', 'delivered'].exclude?(status) || id.to_i < 1
          render json: { error: "invalid status or id" }, status: :unprocessable_entity
        else
          order = Order.find(id)
          order.update(order_status: OrderStatus.find_by(name: status))
          render json: { status: 'success' }        
        end
      end


    end
  
  end
  