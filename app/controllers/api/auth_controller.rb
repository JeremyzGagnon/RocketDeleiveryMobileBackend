module Api
    class AuthController < ActionController::Base
        skip_before_action :verify_authenticity_token
        def index
            data = JSON.parse(request.body.read)
            # puts "DATA"
            # puts data
            email = data["email"]
            password = data["password"]
            user = User.find_by(email: email)
            user_id = user.id
            customer = Customer.find_by(user_id: user_id)
            customer_id = customer.id
            courier = Courier.find_by(user_id: user_id)
            courier_id = courier.id

            if user && user.valid_password?(password)
                render json: { success: true, user_id: user_id, customer_id: customer_id, courier_id: courier_id}
            else
                render json: { success: false }, status: :unauthorized
            end
        end
        
    end
    
end
