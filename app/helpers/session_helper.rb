helpers do
  def session_logged_in?
    !session_current_user.nil?
  end

  def session_current_user_id
    session[:current_user_id]
  end

  def session_set_current_user user
    session[:current_user_id] = user.id
    @current_user = user
  end

  def session_current_user
    return nil if session_current_user_id.blank?
    begin
      @current_user ||= User.find(session_current_user_id)
    rescue
      session_logout
    end
  end

  def session_logout_and_redirect
    session_logout
    redirect '/'
  end

  def session_authenticate email, password
    candidate = User.find_by(:email => email)
    unless candidate.blank?

      if candidate.password_hash.blank?
        # Use Unsafe Old Password
        session_set_current_user candidate if candidate.read_attribute(:password) == password
      else
        # Use BCrypt Override
        session_set_current_user candidate if candidate.password == password
      end
    else
      false
    end
  end

  def session_logout
    session.delete :current_user_id
    @session_current_user = nil
  end

  def session_authenticate!
    return if session_logged_in?
    session[:redirect_target] = request.fullpath if request.get?
    redirect '/session/new'
  end


  def session_redirect_target
    begin
      if session_current_user
        if session[:redirect_target].blank?
          '/secrets'
        else
          session[:redirect_target]
        end
      else
        '/'
      end
    ensure
      session.delete :redirect_target
    end
  end
end
