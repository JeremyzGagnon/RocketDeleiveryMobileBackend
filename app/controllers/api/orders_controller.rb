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
          @orders = Order.where(customer_id: id)
          @order_data = []
          @orders.each do |order|
            customer = Customer.find(order.customer_id)
            restaurant = Restaurant.find(order.restaurant_id)
            courier = Courier.find(order.courier_id).user_id
            order_data = {
              order_id: order.id,
              customer_id: customer.id,
              customer_name: User.find(order.customer_id).name,
              customer_address: Address.find(customer.address_id).street_address,
              restaurant_id: order.restaurant_id,
              restaurant_name: restaurant.name,
              restaurant_address: Address.find(restaurant.address_id).street_address,
              courier_id: order.courier_id,
              courier_name: User.find(courier).name,
              status: OrderStatus.find(order.order_status_id).name,
              product_orders: order.product_orders.map do |product_order|
                cost = product_order.product_unit_cost * product_order.product_quantity
                {
                  product_id: product_order.product_id,
                  product_name: Product.find(product_order.product_id).name,
                  quantity: product_order.product_quantity,
                  unit_cost: product_order.product_unit_cost,
                  total_cost: cost
                }
              end
            }
            @order_data << order_data
          end
          render json: @order_data
                                
                  
        elsif type == "restaurant"
          @orders = Order.where(restaurant_id: id)
          @order_data = []
          @orders.each do |order|
            customer = Customer.find(order.customer_id)
            restaurant = Restaurant.find(order.restaurant_id)
            courier = Courier.find(order.courier_id).user_id
            order_data = {
              order_id: order.id,
              customer_id: customer.id,
              customer_name: User.find(order.customer_id).name,
              customer_address: Address.find(customer.address_id).street_address,
              restaurant_id: order.restaurant_id,
              restaurant_name: restaurant.name,
              restaurant_address: Address.find(restaurant.address_id).street_address,
              courier_id: order.courier_id,
              courier_name: User.find(courier).name,
              status: OrderStatus.find(order.order_status_id).name,
              product_orders: order.product_orders.map do |product_order|
                cost = product_order.product_unit_cost * product_order.product_quantity
                {
                  product_id: product_order.product_id,
                  product_name: Product.find(product_order.product_id).name,
                  quantity: product_order.product_quantity,
                  unit_cost: product_order.product_unit_cost,
                  total_cost: cost
                }
              end
            }
            @order_data << order_data
          end
          render json: @order_data

        elsif type == "courier"
          @orders = Order.where(courier_id: id)
          @order_data = []
          @orders.each do |order|
            customer = Customer.find(order.customer_id)
            restaurant = Restaurant.find(order.restaurant_id)
            courier = Courier.find(order.courier_id).user_id
            order_data = {
              order_id: order.id,
              customer_id: customer.id,
              customer_name: User.find(order.customer_id).name,
              customer_address: Address.find(customer.address_id).street_address,
              restaurant_id: order.restaurant_id,
              restaurant_name: restaurant.name,
              restaurant_address: Address.find(restaurant.address_id).street_address,
              courier_id: order.courier_id,
              courier_name: User.find(courier).name,
              status: OrderStatus.find(order.order_status_id).name,
              product_orders: order.product_orders.map do |product_order|
                cost = product_order.product_unit_cost * product_order.product_quantity
                {
                  product_id: product_order.product_id,
                  product_name: Product.find(product_order.product_id).name,
                  quantity: product_order.product_quantity,
                  unit_cost: product_order.product_unit_cost,
                  total_cost: cost
                }
              end
            }
            @order_data << order_data
          end
          render json: @order_data
          
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
  