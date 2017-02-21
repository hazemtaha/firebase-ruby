require 'openssl'
require 'googleauth'
require 'googleauth/web_user_authorizer'
require 'googleauth/stores/file_token_store'

module Firebase
  class Middleware

    def initialize(app)
      @app = app
      secret = Rails.application.config.firebase.authentication
      scopes =  %w(https://www.googleapis.com/auth/firebase.database https://www.googleapis.com/auth/userinfo.email)

      @credentials = Google::Auth::DefaultCredentials.make_creds(json_key_io: StringIO.new(secret), scope: scopes)
    end

    def call(env)
      config = Rails.application.config.firebase
      env['firebase'] = Firebase::Client.new(config.base_url, @credentials)
      @app.call(env)
    end

  end
end
