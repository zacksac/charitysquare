class User::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
   def new
   puts '___________________post signin'
     super
   end

  # POST /resource/sign_in
   def create
   puts 'signing in __________________'
   super
   end

    def after_sign_in_path_for(resource)
      if resource.role == "admin"
        rails_admin.dashboard_path
      elsif resource.role == "charity"
        if current_user.confirmed == true
          flash[:notice] = "Signed In Successfully!!"
          home_page_feed_url
        else
          sign_out current_user
          flash[:notice] = "Confirmation Pending"
          root_url 
        end
      else   
        if resource.role = "user"
          flash[:notice] = "Signed In Successfully!!"
          home_page_feed_url
        else
          sign_out current_user
          flash[:notice] = "Confirmation Pending"
          root_url  
        end      
      end  
      

    end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
