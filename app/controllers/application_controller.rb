class ApplicationController < ActionController::Base
    # before_action :authenticate_user!
    protect_from_forgery prepend: true
    # private
    # def authenticate_user!
    #   unless user_signed_in? || request.path == root_path || request.path == new_user_session_path
    #     redirect_to new_user_session_path, alert: "You must be logged in to access this page."
    #   end
    # end
  end