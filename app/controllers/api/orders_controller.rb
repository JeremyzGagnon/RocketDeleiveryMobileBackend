module Api
    class OrdersController < ActionController::Base
      skip_before_action :verify_authenticity_token
  
      def set_status
        # puts "PARAMS IG"
        # puts params[:id]
        id = params[:id]
        # puts "PARAMS STATUS"
        # puts params[:status]
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
  