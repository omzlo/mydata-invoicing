# frozen_string_literal: true

require 'net/http'

module MyDATA
  module API
    class TechnicalError < StandardError; end

    class Request
      @@request_count = 0

      def initialize(configuration, method:, command:, body: nil, query_params: nil)
        @config = configuration
        @method = method
        @command = command
        @body = body
        @query_params = query_params
        @failures = []
      end

      def execute(expecting: MyDATA::Schema::ResponseDoc)
        @@request_count += 1
        uri = base_url
        uri.query = URI.encode_www_form(@query_params) if @query_params
        request = http_generate_request(uri.request_uri)
        http_response = http_execute_request(uri, request)
        if @config.log_exchange
          log_exchange(request, http_response)
        end
        Response.new(http_response).tap do |response|
          response.parse(expecting: expecting)
        end
      end

      def base_url
        if @config.live_mode
          URI('https://mydatapi.aade.gr/myDATA/' + @command)
        else
          URI('https://mydataapidev.aade.gr/' + @command)
        end
      end

      private

      def http_generate_request(request_uri)
        request = nil
        if @method == :post
          request = Net::HTTP::Post.new(request_uri)
          request['Content-Type'] = 'application/xml'
        elsif @method == :get
          request = Net::HTTP::Get.new(request_uri)
        else
          raise ArgumentError.new("Unexpected method: #{@method}")
        end
        request['aade-user-id'] = @config.aade_user_id
        request['Ocp-Apim-Subscription-Key'] = @config.ocp_apim_subscription_key
        request['User-Agent'] = "MyDataRuby/#{MyDATA::VERSION}"
        request.body = @body if @body
        request
      end

      def http_execute_request(uri, request)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        if @config.disable_ssl_verify
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        http_response = nil
        http.start do |query|
          http_response = query.request(request)
        end
        http_response
      end

      def log_exchange(request, response)
        timestamp = Time.now.strftime('%Y%m%d%H%M%S-') + @@request_count.to_s
        Dir.mkdir('/tmp/aade-mydata') unless File.exist?('/tmp/aade-mydata')
        filename = "/tmp/aade-mydata/#{@method}-#{@command}-#{timestamp}"
        File.open(filename, "wb") do |file|
          file.write("--- [REQUEST] ---\n")
          file.write("#{request.method} #{request.path}\n")
          file.write("--- [REQUEST HEADERS] ---\n")
          request.each_header do |key, value|
            file.write("#{key}: #{value}\n")
          end
          if request.body
            file.write("--- [REQUEST BODY] ---\n")
            file.write(request.body)
            file.write("\n")
          end
          file.write("--- [RESPONSE HEADERS] ---\n")
          file.write("#{response.code} #{response.message}\n")
          response.each_header do |key, value|
            file.write("#{key}: #{value}\n")
          end
          file.write("--- [RESPONSE] ---\n")
          file.write(response.body)
          file.write("\n--- [END] ---\n")
        end
        puts "Saved MyData response to #{filename}"
      end
    end
  end
end
