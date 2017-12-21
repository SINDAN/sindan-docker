module RequestMacros
  def request_login_user
    before(:each) do
      @loginuser = FactoryBot.create(:login_user)
      post user_session_path, params: { user: { login: @loginuser.login, password: @loginuser.password } }
      follow_redirect!
    end
  end

  def request_admin_user
    before(:each) do
      @loginuser = FactoryBot.create(:login_user)
      post user_session_path, params: { user: { login: @loginuser.login, password: @loginuser.password } }
      follow_redirect!
    end
  end
end
