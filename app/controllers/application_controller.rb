class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    before_action :find_models, if: -> { user_signed_in? }

    private
    
    def find_models
      @categories = Category.all.pluck(:name, :id)
      @businesses = current_user.businesses
      if params[:id].present?
        @current_business ||= current_user.businesses.find(params[:id])
      end
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :surname, :avatar, :admin])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :surname, :avatar, :admin])
    end
end
