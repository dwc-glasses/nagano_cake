class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_customers_path
    when Customer
      public_root_path
    end
  end

  protected
  def configure_permitted_parameters
    if resource_class == Customer
      devise_parameter_sanitizer.permit(:sign_up, keys: [:family_name, :given_name, :family_name_kana, :given_name_kana, :email, :postal_code, :address, :phone])
      devise_parameter_sanitizer.permit(:sign_in,keys:[:email])
    end
  end

end
