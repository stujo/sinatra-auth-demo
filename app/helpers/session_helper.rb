helpers do
  def session_logged_in?
    false
  end

  def session_current_user_id
    nil
  end

  def session_set_current_user user
  end

  def session_current_user
    nil
  end

  def session_logout
  end

  def session_authenticate!
    halt 400, 'Go away stranger'
  end
end
