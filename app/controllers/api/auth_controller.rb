module Api
    class AuthController < ActionController::Base
        skip_before_action :verify_authenticity_token
        def index
            data = JSON.parse(request.body.read)
            email = data["email"]
            password = data["password"]
            user = User.find_by(email: email)
            # puts user
            if user && user.valid_password?(password)
                render json: { success: true}
            else
                render json: { success: false }, status: :unauthorized
            end
        end
        
    end
    
end
