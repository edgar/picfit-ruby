require 'openssl'

module Picfit
  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    PICFIT_PARAMS_MAP = {
      path:      :path,
      operation: :op,
      url:       :url,
      width:     :w,
      height:    :h,
      upscale:   :upscale,
      format:    :fmt,
      quality:   :q,
      degree:    :deg,
      position:  :pos
    }.freeze

    def initialize(options={})
      options = Picfit.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end

    #
    # Return a full image url
    #
    def image_url(options = {})
      base_url = options[:base_url] || self.base_url || Configuration.DEFAULT_BASE_URL
      base_url << "/" if base_url[-1,1] != "/"
      base_url << image_path(options)
    end

    #
    # Return the image path (not include the host)
    #
    def image_path(options = {})
      path = (options[:method] || self.method).to_s
      secret_key = options[:secret_key] || self.secret_key

      # lets convert the options to picfit params
      params = PICFIT_PARAMS_MAP.inject({}) do |result, (key, param_key)|
        result[param_key] = options[key] if options[key]
        result
      end

      if options[:query_string]
        # Create a query params array from the params
        query_string = params.map{|k,v| [CGI.escape(k.to_s), "=", CGI.escape(v.to_s)]}.map(&:join).join("&")
        if secret_key
          # lets use << instead of + or interpolation
          query_string << "&sig="
          query_string << sign_string(secret_key, query_string)
        end
      else
        path << ["", params[:op], [params[:w].to_s, params[:h].to_s].join('x'), params[:path]].join("/")
      end

      if query_string
        path << "?"
        path << query_string
      end

      path
    end

    def sign_string(secret_key, query_string)
      hmac = OpenSSL::HMAC.new(secret_key, sha_digest)
      hmac << query_string
      hmac.hexdigest
    end

    def sha_digest
      @sha_digest ||= OpenSSL::Digest::SHA1.new
    end

  end
end
