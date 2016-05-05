class DeviseOverrides::SessionsController < DeviseTokenAuth::SessionsController

  def create
    # Check
    field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
    render_create_error_bad_credentials and return unless !!field

    q_value = resource_params[field]
    q_value.downcase! if resource_class.case_insensitive_keys.include?(field)
    @resource = User.find_for_auth(q_value).first

    if @resource and valid_params?(field, q_value) and @resource.valid_password?(resource_params[:password]) and (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)
      # create client id
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token = SecureRandom.urlsafe_base64(nil, false)
      @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
      }
      @resource.save
      sign_in(:user, @resource, store: false, bypass: false)
      yield if block_given?
      render_create_success
    elsif @resource and not (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)
      render_create_error_not_confirmed
    else
      render_create_error_bad_credentials
    end
  end

  protected

  def render_create_success
    render json: @resource, serializer: UserSerializer, status: :created
  end

end