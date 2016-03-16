module Picfit
  module Configuration
    # An array of valid keys in the options hash
    VALID_OPTIONS_KEYS = [
      :base_url,
      :method,
      :secret_key,
      :query_string
    ].freeze

    DEFAULT_METHOD        = :display
    DEFAULT_BASE_URL      = ""
    DEFAULT_SECRET_KEY    = nil
    DEFAULT_QUERY_STRING  = false

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.base_url       = DEFAULT_BASE_URL
      self.method         = DEFAULT_METHOD
      self.secret_key     = DEFAULT_SECRET_KEY
      self.query_string   = DEFAULT_QUERY_STRING
    end
  end
end
