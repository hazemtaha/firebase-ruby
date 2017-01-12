require 'firebase/configuration'
require 'firebase/middleware'

module Firebase
  class Railtie < Rails::Railtie
    config.firebase = Firebase::Configuration.new

    unless Rails.env.test?
      initializer 'firebase.middleware' do |app|
        app.middleware.use Firebase::Middleware
      end

      config.before_initialize do
        if config.firebase.base_url.blank?
          raise "You need to set a base URL for firebase. config.firebase.base_url = 'https://<your-firebase>.firebaseio.com/'"
        end
      end
    end
  end
end
