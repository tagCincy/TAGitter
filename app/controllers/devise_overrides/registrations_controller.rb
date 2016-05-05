class DeviseOverrides::RegistrationsController < DeviseTokenAuth::RegistrationsController

  protected

  def render_create_success
    render json: @resource, serializer: UserSerializer, status: :created
  end

end