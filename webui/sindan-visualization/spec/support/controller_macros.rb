module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @loginuser = FactoryBot.create(:login_user)
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @loginuser
    end

    after(:each) do
      @loginuser.destroy
    end
  end

  def http_login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      loginuser = FactoryBot.create(:user)
      @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(loginuser.login, loginuser.password)
    end
  end
end
