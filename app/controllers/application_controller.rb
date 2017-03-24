class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.sign_in_path, :alert => exception.message
  end

 # def current_ability
 #  @current_ability ||= Ability.new(current_admin_user)
  
 # end

rescue_from ActiveRecord::RecordNotFound do
  flash[:warning] = 'Resource not found.'
  redirect_back_or root_path
end
 
def redirect_back_or(path)
  redirect_to request.referer || path
end

def configure_sign_up_params
  devise_parameter_sanitizer.for(:sign_up) do |u|
    u.permit :email, :password, :password_confirmation, :formtype ,:role,:firstname,:lastname,:charityname,:charitytype,:charitynumber,:category,:country,:town,:postcode,:webaddress,:picture,:mission,:opt1,:opt2,:address1,:address2,:phone_number,:follow_status,:title,:phone_code,:primary_address1,:primary_address2,:primary_address3,:primary_address4,:primary_address_pin,:secondary_address1,:secondary_address2,:secondary_address3,:secondary_address4,:secondary_address_pin,:allow_emails_from_followed_charities,:subscription_to_charity_square_emails,:suggestions,:tailored_ads,:display_name,:UK_taxpayer,:ni_number,:profile_type,:email_type,:same_address,:paypal_email
  end
end


end
