class LoginApi < Grape::API
  include Concerns::Base

  params do
    optional :mobile,    type: Integer,  desc: "phone number"
    optional :email,     type: String,   desc: "email"
    requires :password,  type: String,   desc: "password"
  end

  resource :login do

    post '/' do
      @user = User.authenticate((params[:mobile]||params[:email]), @password)
      if @user
        @access_token, @refresh_token = send_access_token(@user, @provider, @device_model, @os_version)
        render_template :login
      else
        render_errors code: 10500,  message: "登陆失败！请检查您提供的帐号密码！"
      end
    end

  end

end
