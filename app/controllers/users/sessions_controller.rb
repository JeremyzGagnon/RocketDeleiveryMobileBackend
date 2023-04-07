class Users::SessionsController < Devise::SessionsController
    def create
      user = User.find_by(email: params[:user][:email])
      puts "User: #{user.inspect}"
      employee = Employee.find_by(user_id: user.id)
      if employee.nil?
        flash[:alert] = "Not an employee."
        redirect_to new_user_session_path
      else
        super
      end
    end
  end