module RequestHelpers
  include Warden::Test::Helpers

  def login
    before(:each) do
      @user = create(:user)
      @auth_headers = @user.create_new_auth_token
    end
  end

end