class ApplicationController < ActionController::Base
    protect_from_forgery prepend: true, with: :exception      
    skip_before_action :verify_authenticity_token 
    
    # Probably add more here to restrict users from directly accessing the back-office
    # def require_admin # This is from Blazer..
    #     # depending on your auth, something like...
    #     redirect_to root_path unless current_user && current_user.superadmin?
    # end
end
