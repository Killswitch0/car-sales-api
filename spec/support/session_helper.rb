module SessionHelper
  def log_in(user)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    
    secret = Rails.application.credentials.devise_jwt_secret_key
    
    encoding = 'HS512'
  
    request.headers["Authorization"] = 
      JWT.encode({ user_id: user.id }, secret, encoding)
  end
end