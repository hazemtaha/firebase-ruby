module Firebase
  class Configuration < Rails::Railtie::Configuration
    attr_accessor :base_url, :authentication
  end
end
