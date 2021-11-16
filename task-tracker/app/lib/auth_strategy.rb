require 'omniauth-oauth2'

class AuthStrategy < OmniAuth::Strategies::OAuth2
  # Give your strategy a name.
  option :name, 'auth'

  # This is where you pass the options you would pass when
  # initializing your consumer from the OAuth gem.
  option :client_options, { site: 'http://localhost:3001' }

  # You may specify that your strategy should use PKCE by setting
  # the pkce option to true: https://tools.ietf.org/html/rfc7636
  option :pkce, true

  # These are called after authentication has succeeded. If
  # possible, you should try to set the UID without making
  # additional calls (if the user id is returned with the token
  # or as a URI parameter). This may not be possible with all
  # providers.
  uid { raw_info['public_id'] }

  info do
    {
      email: raw_info['email'],
      public_id: raw_info['public_id'],
      first_name: raw_info['first_name'],
      last_name: raw_info['last_name'],
      role: raw_info['role']
    }
  end

  extra do
    {
      'raw_info' => raw_info
    }
  end

  def raw_info
    @raw_info ||= access_token.get('/users/current').parsed
  end
end
