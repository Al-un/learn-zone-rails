# frozen_string_literal: true

# Auth0 callback handling controller
class Auth0Controller < ApplicationController
  # Handle an Auth0 callback
  def callback
    # This stores all the user information that came from Auth0
    # and the IdP => Hash is string based
    session[:userinfo] = request.env['omniauth.auth']

    # Redirect to the URL you want after successful auth
    redirect_to '/'
  end

  # Handle an Auth0 failure
  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end
end
