class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def permission_denied
    params[:controller] =~ /api\/v1\/public\/.?/ ? head(:not_found) : head(:forbidden)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :handle, :password, :password_confirmation, profile_attributes: [:name, :bio, :location, :dob, :protected] ])
  end

end
