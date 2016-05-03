class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  private

  def permission_denied
    head(:forbidden)
  end

end
