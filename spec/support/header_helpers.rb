module HeaderHelpers
  def request_header(user)
    {
      'X-User-Email' => user.email,
      'X-User-Token' => user.authentication_token
    }
  end
end
