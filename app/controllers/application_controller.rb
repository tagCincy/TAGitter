class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  private

  def permission_denied
    params[:controller] =~ /api\/v1\/public\/.?/ ? head(:not_found) : head(:forbidden)
  end

end
