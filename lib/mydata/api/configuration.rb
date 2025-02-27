# frozen_string_literal: true

module MyDATA
  module API
    class Configuration
      attr_accessor :aade_user_id,
        :ocp_apim_subscription_key,
        :live_mode,
        :disable_ssl_verify,
        :log_exchange

      def initialize(aade_user_id:,
                     ocp_apim_subscription_key:,
                     live_mode: false,
                     disable_ssl_verify: false,
                     log_exchange: true)
        @aade_user_id = aade_user_id
        @ocp_apim_subscription_key = ocp_apim_subscription_key
        @live_mode = live_mode
        @disable_ssl_verify = disable_ssl_verify
        @log_exchange = log_exchange
      end
    end
  end
end
